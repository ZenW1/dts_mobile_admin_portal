import 'package:dartz/dartz.dart';
import '../../../../core/network/api_catch_exception.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../generated_code/swagger.swagger.dart';
import '../../domain/entities/product.dart';
import '../../domain/entities/product_category.dart';
import '../../domain/repositories/product_repository.dart';
import '../product_mapper.dart';

class ProductRepositoryImpl implements ProductRepository {
  final Swagger _api;

  ProductRepositoryImpl(this._api);

  @override
  Future<Either<String, List<ProductResponseDTO>>> getAllProducts() async {
    try {
      final response = await _api.GetAllProducts();
      if (response.isSuccessful) {
        final body = response.body;
        if (body != null) {
          final products = body.data.map((dto) => dto).toList();
          return Right(products);
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
  Future<Either<String, SingleProductResponseDTO?>> getProductById(String id) async {
    try {
      final response = await _api.GetProductById(productId: id);
      if (response.isSuccessful) {
        final body = response.body;
        if (body != null) {
          return Right(body);
        }
        return const Right(null);
      } else {
        return Left(ApiCatchException(response).catchException());
      }
    } catch (e) {
      return Left('An unexpected error occurred: $e');
    }
  }

  @override
  Future<Either<String, SingleProductResponseDTO>> createProduct(
      CreateProductDTO product) async {
    try {
      final response = await _api.CreateProduct(body: product);
      if (response.isSuccessful) {
        final body = response.body;
        if (body != null) {
          return Right(body);
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
  Future<Either<String, SingleProductResponseDTO>> updateProduct(
      String id, CreateProductDTO product) async {
    try {
      final response = await _api.UpdateProduct(productId: id, body: product);
      if (response.isSuccessful) {
        final body = response.body;
        if (body != null) {
          return Right(body);
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
  Future<Either<String, void>> deleteProduct(String id) async {
    try {
      final response = await _api.DeleteProduct(productId: id);
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
  Future<Either<String, List<ProductCategory>>> getAllCategories() async {
    try {
      final response = await _api.GetAllProductCategories();
      if (response.isSuccessful) {
        final body = response.body;
        if (body != null) {
          final categories = body.data.map((dto) {
            final m = dto.toJson();
            return ProductCategory(
              id: m['_id'] ?? '',
              name: m['name'] ?? '',
              description: m['description'],
              createdAt: m['createdAt'] != null
                  ? DateTime.tryParse(m['createdAt'])
                  : null,
              updatedAt: m['updatedAt'] != null
                  ? DateTime.tryParse(m['updatedAt'])
                  : null,
            );
          }).toList();
          return Right(categories);
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
  Future<Either<String, ProductCategory>> createCategory(
      ProductCategory category) async {
    try {
      final dto = CreateProductCategoryDTO(
        name: category.name,
        description: category.description,
      );
      final response = await _api.CreateProductCategory(body: dto);
      if (response.isSuccessful) {
        final body = response.body;
        if (body != null) {
          final m = body.toJson();
          return Right(ProductCategory(
            id: m['_id'] ?? '',
            name: m['name'] ?? '',
            description: m['description'],
          ));
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
  Future<Either<String, ProductCategory>> updateCategory(
      String id, ProductCategory category) async {
    try {
      final dto = CreateProductCategoryDTO(
        name: category.name,
        description: category.description,
      );
      final response =
          await _api.UpdateProductCategory(categoryId: id, body: dto);
      if (response.isSuccessful) {
        final body = response.body;
        if (body != null) {
          final m = body.toJson();
          return Right(ProductCategory(
            id: m['_id'] ?? '',
            name: m['name'] ?? '',
            description: m['description'],
          ));
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
  Future<Either<String, void>> deleteCategory(String id) async {
    try {
      final response = await _api.DeleteProductCategory(categoryId: id);
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

ProductRepository createProductRepository() => ProductRepositoryImpl(ApiServiceProvider().restApi);
