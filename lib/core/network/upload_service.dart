import 'dart:convert';
import 'package:http_parser/http_parser.dart';
import 'dart:io';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import 'dio_client.dart';

class UploadService {
  final _api = ApiServiceProvider().restApi;
  final _logger = Logger();

  Future<String?> _compressImage(String imagePath) async {
    try {
      final file = File(imagePath);
      final tempDir = await getTemporaryDirectory();
      final targetPath = p.join(
        tempDir.path,
        "${DateTime.now().millisecondsSinceEpoch}_compressed${p.extension(imagePath)}",
      );

      final result = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path,
        targetPath,
        quality: 70, // Adjust quality as needed
        minWidth: 1024,
        minHeight: 1024,
      );

      if (result != null) {
        final compressedFile = File(result.path);
        _logger.i('Original size: ${await file.length()} bytes');
        _logger.i('Compressed size: ${await compressedFile.length()} bytes');
        return compressedFile.path;
      }
      return null;
    } catch (e) {
      _logger.e('Error compressing image: $e');
      return null;
    }
  }

  Future<String?> uploadImageBytes(String imagePath) async {
    File? compressedFile;
    try {
      final url = Uri.parse('${_api.client.baseUrl}/images/upload');
      print('Uploading image to: $url');

      // Compress the image first
      final compressedPath = await _compressImage(imagePath);
      final finalPath = compressedPath ?? imagePath;
      if (compressedPath != null) {
        compressedFile = File(compressedPath);
      }

      final request = http.MultipartRequest('POST', url);
      print('Preparing multipart request for image: $finalPath');

      // Add file to multipart request
      if (finalPath.isNotEmpty) {
        final file = File(finalPath);
        if (!await file.exists()) {
          _logger.e('File does not exist at path: $finalPath');
          return null;
        }

        final fileLength = await file.length();
        _logger.i('Uploading file of size: $fileLength bytes');

        // Determine content type
        final extension = finalPath.split('.').last.toLowerCase();
        String mimeType = 'image/jpeg';
        if (extension == 'png') {
          mimeType = 'image/png';
        } else if (extension == 'gif') {
          mimeType = 'image/gif';
        } else if (extension == 'webp') {
          mimeType = 'image/webp';
        }

        request.files.add(
          await http.MultipartFile.fromPath(
            'file',
            finalPath,
            contentType: MediaType.parse(mimeType),
          ),
        );
      } else {
        _logger.e('File path is empty');
        return null;
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final responseBody = jsonDecode(response.body);

        if (responseBody is Map<String, dynamic>) {
          if (responseBody.containsKey('data') &&
              responseBody['data'] is Map<String, dynamic>) {
            final data = responseBody['data'] as Map<String, dynamic>;
            if (data.containsKey('secure_url')) {
              return data['secure_url'] as String;
            } else if (data.containsKey('url')) {
              return data['url'] as String;
            }
          }

          // Fallbacks for older formats if any
          if (responseBody.containsKey('url')) {
            return responseBody['url'] as String;
          } else if (responseBody.containsKey('image')) {
            return responseBody['image'] as String;
          }
        } else if (responseBody is String) {
          return responseBody;
        }

        _logger
            .w('Unexpected response format from uploadImage: ${response.body}');
        return response.body;
      } else {
        _logger.e(
            'Failed to upload image: ${response.statusCode} - ${response.reasonPhrase}');
        return null;
      }
    } catch (e) {
      _logger.e('Exception uploading image: $e');
      return null;
    } finally {
      // Clean up compressed file if it exists
      if (compressedFile != null && await compressedFile.exists()) {
        try {
          await compressedFile.delete();
          _logger.i('Cleaned up compressed file: ${compressedFile.path}');
        } catch (e) {
          _logger.w('Failed to delete compressed file: $e');
        }
      }
    }
  }
}
