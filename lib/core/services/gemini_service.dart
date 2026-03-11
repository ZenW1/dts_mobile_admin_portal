import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dts_admin_portal/core/constants/api_constants.dart';
import 'package:dts_admin_portal/core/network/dio_client.dart'; // for logger

/// Service to interact with Google Gemini API
class GeminiService {
  /// Generates a product description based on the product name
  Future<String> generateProductDescription(String productName) async {
    if (ApiConstants.geminiApiKey == 'YOUR_GEMINI_API_KEY') {
      throw Exception(
          'Gemini API Key is not configured. Please add your key in api_constants.dart');
    }

    try {
      final response = await http.post(
        Uri.parse(ApiConstants.geminiUrl),
        headers: {
          'Content-Type': 'application/json',
          'X-goog-api-key': ApiConstants.geminiApiKey,
        },
        body: jsonEncode({
          'contents': [
            {
              'parts': [
                {
                  'text':
                      'You are a marketing copywriter. Write an attractive and professional product description for "$productName". Start with a catchy engaging prefix. Keep it to 2-3 sentences, focusing on making the product sound appealing to customers.'
                }
              ]
            }
          ],
          'generationConfig': {
            'temperature': 0.7,
            'topK': 40,
            'topP': 0.95,
            'maxOutputTokens': 1024,
          }
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final content =
            data['candidates'][0]['content']['parts'][0]['text'] as String;
        return content.trim();
      } else {
        logger.e('Gemini Error: ${response.statusCode} - ${response.body}');
        final errorData = jsonDecode(response.body);
        final errorMessage =
            errorData['error']?['message'] ?? 'Failed to generate description';
        throw Exception(errorMessage);
      }
    } catch (e) {
      logger.e('Gemini Service Exception: $e');
      rethrow;
    }
  }
}
