import 'package:dartz/dartz.dart';
import '../../../../generated_code/swagger.swagger.dart';
import '../entities/product.dart';
import '../entities/product_category.dart';

/// Product repository interface
abstract class ProductRepository {
  Future<Either<String, List<ProductResponseDTO>>> getAllProducts();

  Future<Either<String, SingleProductResponseDTO?>> getProductById(String id);

  Future<Either<String, SingleProductResponseDTO>> createProduct(
      CreateProductDTO product);

  Future<Either<String, SingleProductResponseDTO>> updateProduct(
      String id, CreateProductDTO product);

  Future<Either<String, void>> deleteProduct(String id);

  Future<Either<String, List<ProductCategory>>> getAllCategories();

  Future<Either<String, ProductCategory>> createCategory(
      ProductCategory category);

  Future<Either<String, ProductCategory>> updateCategory(
      String id, ProductCategory category);

  Future<Either<String, void>> deleteCategory(String id);
}
