import 'package:dartz/dartz.dart';
import '../entities/product_color.dart';

/// Abstract repository for ProductColor CRUD operations
abstract class ProductColorRepository {
  Future<Either<String, List<ProductColor>>> getAllColors();

  Future<Either<String, ProductColor>> getColorById(String id);

  Future<Either<String, ProductColor>> createColor({
    required String name,
    String? hexCode,
  });

  Future<Either<String, ProductColor>> updateColor({
    required String id,
    required String name,
    String? hexCode,
  });

  Future<Either<String, void>> deleteColor(String id);
}
