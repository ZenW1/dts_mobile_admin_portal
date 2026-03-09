import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/product_material.dart';
import '../../domain/repositories/product_material_repository.dart';
import '../../data/repositories/product_material_repository_impl.dart';

/// Provider for ProductMaterialRepository
final productMaterialRepositoryProvider =
    Provider<ProductMaterialRepository>((ref) {
  return createProductMaterialRepository();
});

/// Notifier for managing ProductMaterial CRUD
class ProductMaterialsNotifier
    extends StateNotifier<AsyncValue<List<ProductMaterial>>> {
  final ProductMaterialRepository _repository;

  ProductMaterialsNotifier(this._repository)
      : super(const AsyncValue.loading()) {
    loadMaterials();
  }

  Future<void> loadMaterials() async {
    state = const AsyncValue.loading();
    final result = await _repository.getAllMaterials();
    result.fold(
      (error) => state = AsyncValue.error(error, StackTrace.current),
      (materials) => state = AsyncValue.data(materials),
    );
  }

  Future<bool> createMaterial(
      {required String name, String? description}) async {
    final result =
        await _repository.createMaterial(name: name, description: description);
    return result.fold(
      (error) => false,
      (material) {
        loadMaterials();
        return true;
      },
    );
  }

  Future<bool> updateMaterial({
    required String id,
    required String name,
    String? description,
  }) async {
    final result = await _repository.updateMaterial(
        id: id, name: name, description: description);
    return result.fold(
      (error) => false,
      (material) {
        loadMaterials();
        return true;
      },
    );
  }

  Future<bool> deleteMaterial(String id) async {
    final result = await _repository.deleteMaterial(id);
    return result.fold(
      (error) => false,
      (_) {
        loadMaterials();
        return true;
      },
    );
  }
}

/// Provider for ProductMaterialsNotifier
final productMaterialsNotifierProvider = StateNotifierProvider<
    ProductMaterialsNotifier, AsyncValue<List<ProductMaterial>>>((ref) {
  final repository = ref.watch(productMaterialRepositoryProvider);
  return ProductMaterialsNotifier(repository);
});

/// Provider for single material detail
final productMaterialDetailProvider =
    FutureProvider.family<ProductMaterial?, String>((ref, id) async {
  final repository = ref.watch(productMaterialRepositoryProvider);
  final result = await repository.getMaterialById(id);
  return result.fold(
    (error) => throw Exception(error),
    (material) => material,
  );
});
