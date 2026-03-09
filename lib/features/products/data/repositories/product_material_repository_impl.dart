import 'package:dartz/dartz.dart';
import '../../../../core/network/api_catch_exception.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../generated_code/swagger.swagger.dart';
import '../../domain/entities/product_material.dart';
import '../../domain/repositories/product_material_repository.dart';
import '../product_material_mapper.dart';

class ProductMaterialRepositoryImpl implements ProductMaterialRepository {
  final Swagger _api;

  ProductMaterialRepositoryImpl(this._api);

  @override
  Future<Either<String, List<ProductMaterial>>> getAllMaterials() async {
    try {
      final response = await _api.GetAllProductMaterials();
      if (response.isSuccessful) {
        final body = response.body;
        if (body != null) {
          final materials =
              body.data.map((dto) => dto.toJson().toDomain()).toList();
          return Right(materials);
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
  Future<Either<String, ProductMaterial>> getMaterialById(String id) async {
    try {
      final response = await _api.GetProductMaterialById(materialId: id);
      if (response.isSuccessful) {
        final body = response.body;
        if (body != null) {
          return Right(body.toJson().toDomain());
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
  Future<Either<String, ProductMaterial>> createMaterial({
    required String name,
    String? description,
  }) async {
    try {
      final dto =
          CreateProductMaterialDTO(name: name, description: description);
      final response = await _api.CreateProductMaterial(body: dto);
      if (response.isSuccessful) {
        final body = response.body;
        if (body != null) {
          return Right(body.toJson().toDomain());
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
  Future<Either<String, ProductMaterial>> updateMaterial({
    required String id,
    required String name,
    String? description,
  }) async {
    try {
      final dto =
          CreateProductMaterialDTO(name: name, description: description);
      final response =
          await _api.UpdateProductMaterial(materialId: id, body: dto);
      if (response.isSuccessful) {
        final body = response.body;
        if (body != null) {
          return Right(body.toJson().toDomain());
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
  Future<Either<String, void>> deleteMaterial(String id) async {
    try {
      final response = await _api.DeleteProductMaterial(materialId: id);
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

/// Factory for easy injection
ProductMaterialRepository createProductMaterialRepository() =>
    ProductMaterialRepositoryImpl(ApiServiceProvider().restApi);
