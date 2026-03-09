import 'package:dartz/dartz.dart';
import '../../../../core/network/api_catch_exception.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../generated_code/swagger.swagger.dart';
import '../../domain/entities/product_color.dart';
import '../../domain/repositories/product_color_repository.dart';
import '../product_color_mapper.dart';

class ProductColorRepositoryImpl implements ProductColorRepository {
  final Swagger _api;

  ProductColorRepositoryImpl(this._api);

  @override
  Future<Either<String, List<ProductColor>>> getAllColors() async {
    try {
      final response = await _api.GetAllProductColors();
      if (response.isSuccessful) {
        final body = response.body;
        if (body != null) {
          final colors =
              body.data.map((dto) => dto.toJson().toDomain()).toList();
          return Right(colors);
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
  Future<Either<String, ProductColor>> getColorById(String id) async {
    try {
      final response = await _api.GetProductColorById(colorId: id);
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
  Future<Either<String, ProductColor>> createColor({
    required String name,
    String? hexCode,
  }) async {
    try {
      final dto = CreateProductColorDTO(name: name, hexCode: hexCode);
      final response = await _api.CreateProductColor(body: dto);
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
  Future<Either<String, ProductColor>> updateColor({
    required String id,
    required String name,
    String? hexCode,
  }) async {
    try {
      final dto = CreateProductColorDTO(name: name, hexCode: hexCode);
      final response = await _api.UpdateProductColor(colorId: id, body: dto);
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
  Future<Either<String, void>> deleteColor(String id) async {
    try {
      final response = await _api.DeleteProductColor(colorId: id);
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

/// Provider factory for easy injection
ProductColorRepository createProductColorRepository() =>
    ProductColorRepositoryImpl(ApiServiceProvider().restApi);
