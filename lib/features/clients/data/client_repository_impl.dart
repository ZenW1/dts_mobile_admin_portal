import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../../../../core/network/api_catch_exception.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../generated_code/swagger.swagger.dart';
import '../domain/entities/client.dart';
import 'client_mapper.dart';
import 'client_repository.dart';

class ClientRepositoryImpl implements ClientRepository {
  final Swagger _api;

  ClientRepositoryImpl(this._api);

  @override
  Future<Either<String, List<Client>>> getClients({
    String? query,
    ClientStatus? status,
    String? sortBy,
    String? sortOrder,
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final response = await _api.getAllClients(
        q: query,
        status: status != null
            ? ApiClientsGetStatus.values.firstWhere(
                (e) => e.value == status.name,
                orElse: () => ApiClientsGetStatus.swaggerGeneratedUnknown)
            : null,
        sortBy: sortBy,
        sortOrder: sortOrder != null
            ? ApiClientsGetSortOrder.values.firstWhere(
                (e) => e.value == sortOrder,
                orElse: () => ApiClientsGetSortOrder.swaggerGeneratedUnknown)
            : null,
        page: page,
        limit: limit,
      );

      if (response.isSuccessful) {
        final body = response.body;
        if (body is Map<String, dynamic> && body['data'] is List) {
          final List<dynamic> data = body['data'];
          final clients = data
              .map((json) => (json as Map<String, dynamic>).toDomain())
              .toList();
          return Right(clients);
        } else if (body is List) {
          final clients = body
              .map((json) => (json as Map<String, dynamic>).toDomain())
              .toList();
          return Right(clients);
        }
        return const Right([]);
      } else {
        return Left(ApiCatchException(response).catchException());
      }
    } catch (e) {
      return Left('An unexpected error occurred: $e');
    }
  }

  @override
  Future<Either<String, List<Client>>> searchClients({
    required String query,
    ClientStatus? status,
    String? sortBy,
    String? sortOrder,
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final response = await _api.searchClients(
        q: query,
        status: status != null
            ? ApiClientsSearchGetStatus.values.firstWhere(
                (e) => e.value == status.name,
                orElse: () => ApiClientsSearchGetStatus.swaggerGeneratedUnknown)
            : null,
        sortBy: sortBy,
        sortOrder: sortOrder != null
            ? ApiClientsSearchGetSortOrder.values.firstWhere(
                (e) => e.value == sortOrder,
                orElse: () =>
                    ApiClientsSearchGetSortOrder.swaggerGeneratedUnknown)
            : null,
        page: page,
        limit: limit,
      );

      if (response.isSuccessful) {
        final body = response.body;
        if (body is Map<String, dynamic> && body['data'] is List) {
          final List<dynamic> data = body['data'];
          final clients = data
              .map((json) => (json as Map<String, dynamic>).toDomain())
              .toList();
          return Right(clients);
        } else if (body is List) {
          final clients = body
              .map((json) => (json as Map<String, dynamic>).toDomain())
              .toList();
          return Right(clients);
        }
        return const Right([]);
      } else {
        return Left(ApiCatchException(response).catchException());
      }
    } catch (e) {
      return Left('An unexpected error occurred: $e');
    }
  }

  @override
  Future<Either<String, Client>> getClientById(String id) async {
    try {
      final response = await _api.getClientById(id: id);
      if (response.isSuccessful) {
        final body = response.body;
        if (body is Map<String, dynamic>) {
          final data = body.containsKey('data') ? body['data'] : body;
          return Right((data as Map<String, dynamic>).toDomain());
        }
        return const Left('Unexpected response format');
      } else {
        return Left(ApiCatchException(response).catchException());
      }
    } catch (e) {
      return Left('An unexpected error occurred: $e');
    }
  }

  @override
  Future<Either<String, Client>> createClient(CreateClientDTO clientDto) async {
    try {
      final response = await _api.createClient(body: clientDto);
      if (response.isSuccessful) {
        final body = response.body;
        if (body is Map<String, dynamic>) {
          final data = body.containsKey('data') ? body['data'] : body;
          return Right((data as Map<String, dynamic>).toDomain());
        }
        return const Left('Unexpected response format');
      } else {
        return Left(ApiCatchException(response).catchException());
      }
    } catch (e) {
      return Left('An unexpected error occurred: $e');
    }
  }

  @override
  Future<Either<String, Client>> updateClient(
      String id, UpdateClientDTO clientDto) async {
    try {
      final response = await _api.updateClient(id: id, body: clientDto);
      if (response.isSuccessful) {
        final body = response.body;
        if (body is Map<String, dynamic>) {
          final data = body.containsKey('data') ? body['data'] : body;
          return Right((data as Map<String, dynamic>).toDomain());
        }
        return const Left('Unexpected response format');
      } else {
        return Left(ApiCatchException(response).catchException());
      }
    } catch (e) {
      return Left('An unexpected error occurred: $e');
    }
  }

  @override
  Future<Either<String, void>> deleteClient(String id) async {
    try {
      final response = await _api.deleteClient(id: id);
      if (response.isSuccessful) {
        return const Right(null);
      } else {
        return Left(ApiCatchException(response).catchException());
      }
    } catch (e) {
      return Left('An unexpected error occurred: $e');
    }
  }

  @override
  Future<Either<String, void>> uploadImage(String id, File imageFile) async {
    try {
      final url = Uri.parse(
          '${ApiServiceProvider().restApi.client.baseUrl}/api/clients/$id/image');

      final request = http.MultipartRequest('POST', url);

      final extension = imageFile.path.split('.').last.toLowerCase();
      String mimeType = 'image/jpeg';
      if (extension == 'png') {
        mimeType = 'image/png';
      }

      request.files.add(
        await http.MultipartFile.fromPath(
          'file', // Assuming the field name is 'file'
          imageFile.path,
          contentType: MediaType.parse(mimeType),
        ),
      );

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return const Right(null);
      } else {
        return Left('Failed to upload image: \${response.statusCode}');
      }
    } catch (e) {
      return Left('An unexpected error occurred: $e');
    }
  }

  @override
  Future<Either<String, void>> removeImage(String id) async {
    try {
      final response = await _api.removeClientImage(id: id);
      if (response.isSuccessful) {
        return const Right(null);
      } else {
        return Left(ApiCatchException(response).catchException());
      }
    } catch (e) {
      return Left('An unexpected error occurred: $e');
    }
  }
}
