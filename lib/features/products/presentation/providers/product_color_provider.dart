import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/product_color.dart';
import '../../domain/repositories/product_color_repository.dart';
import '../../data/repositories/product_color_repository_impl.dart';

/// Provider for ProductColorRepository
final productColorRepositoryProvider = Provider<ProductColorRepository>((ref) {
  return createProductColorRepository();
});

/// Notifier for managing ProductColor CRUD
class ProductColorsNotifier
    extends StateNotifier<AsyncValue<List<ProductColor>>> {
  final ProductColorRepository _repository;

  ProductColorsNotifier(this._repository) : super(const AsyncValue.loading()) {
    loadColors();
  }

  Future<void> loadColors() async {
    state = const AsyncValue.loading();
    final result = await _repository.getAllColors();
    result.fold(
      (error) => state = AsyncValue.error(error, StackTrace.current),
      (colors) => state = AsyncValue.data(colors),
    );
  }

  Future<bool> createColor({required String name, String? hexCode}) async {
    final result = await _repository.createColor(name: name, hexCode: hexCode);
    return result.fold(
      (error) => false,
      (color) {
        loadColors();
        return true;
      },
    );
  }

  Future<bool> updateColor({
    required String id,
    required String name,
    String? hexCode,
  }) async {
    final result =
        await _repository.updateColor(id: id, name: name, hexCode: hexCode);
    return result.fold(
      (error) => false,
      (color) {
        loadColors();
        return true;
      },
    );
  }

  Future<bool> deleteColor(String id) async {
    final result = await _repository.deleteColor(id);
    return result.fold(
      (error) => false,
      (_) {
        loadColors();
        return true;
      },
    );
  }
}

/// Provider for ProductColorsNotifier
final productColorsNotifierProvider = StateNotifierProvider<
    ProductColorsNotifier, AsyncValue<List<ProductColor>>>((ref) {
  final repository = ref.watch(productColorRepositoryProvider);
  return ProductColorsNotifier(repository);
});

/// Provider for single color detail
final productColorDetailProvider =
    FutureProvider.family<ProductColor?, String>((ref, id) async {
  final repository = ref.watch(productColorRepositoryProvider);
  final result = await repository.getColorById(id);
  return result.fold(
    (error) => throw Exception(error),
    (color) => color,
  );
});
