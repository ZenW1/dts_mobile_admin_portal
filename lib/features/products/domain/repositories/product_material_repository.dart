import 'package:dartz/dartz.dart';
import '../entities/product_material.dart';

/// Abstract repository for ProductMaterial CRUD operations
abstract class ProductMaterialRepository {
  Future<Either<String, List<ProductMaterial>>> getAllMaterials();

  Future<Either<String, ProductMaterial>> getMaterialById(String id);

  Future<Either<String, ProductMaterial>> createMaterial({
    required String name,
    String? description,
  });

  Future<Either<String, ProductMaterial>> updateMaterial({
    required String id,
    required String name,
    String? description,
  });

  Future<Either<String, void>> deleteMaterial(String id);
}
