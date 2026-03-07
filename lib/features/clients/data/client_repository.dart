import 'dart:io';
import 'package:dartz/dartz.dart';
import '../domain/entities/client.dart';
import '../../../../generated_code/swagger.swagger.dart';

abstract class ClientRepository {
  Future<Either<String, List<Client>>> getClients({
    String? query,
    ClientStatus? status,
    String? sortBy,
    String? sortOrder,
    int page = 1,
    int limit = 20,
  });

  Future<Either<String, List<Client>>> searchClients({
    required String query,
    ClientStatus? status,
    String? sortBy,
    String? sortOrder,
    int page = 1,
    int limit = 20,
  });

  Future<Either<String, Client>> getClientById(String id);

  Future<Either<String, Client>> createClient(CreateClientDTO clientDto);

  Future<Either<String, Client>> updateClient(
      String id, UpdateClientDTO clientDto);

  Future<Either<String, void>> deleteClient(String id);

  Future<Either<String, void>> uploadImage(String id, File imageFile);

  Future<Either<String, void>> removeImage(String id);
}
