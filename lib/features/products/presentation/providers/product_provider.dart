import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../generated_code/swagger.swagger.dart';

import '../../domain/entities/product_category.dart';
import '../../domain/repositories/product_repository.dart';
import '../../data/repositories/product_repository_impl.dart';

/// Provider for ProductRepository
final productRepositoryProvider = Provider<ProductRepository>((ref) {
  return createProductRepository();
});

/// Notifier for managing products CRUD operations
class ProductsNotifier
    extends StateNotifier<AsyncValue<List<ProductResponseDTO>>> {
  final ProductRepository _repository;

  ProductsNotifier(this._repository) : super(const AsyncValue.loading()) {
    loadProducts();
  }

  Future<void> loadProducts() async {
    state = const AsyncValue.loading();
    final result = await _repository.getAllProducts();
    result.fold(
      (error) => state = AsyncValue.error(error, StackTrace.current),
      (products) => state = AsyncValue.data(products),
    );
  }

  Future<bool> addProduct(CreateProductDTO product) async {
    final result = await _repository.createProduct(product);
    return result.fold(
      (error) => false,
      (p) {
        loadProducts();
        return true;
      },
    );
  }

  Future<bool> updateProduct(CreateProductDTO product, String id) async {
    final result = await _repository.updateProduct(id, product);
    return result.fold(
      (error) => false,
      (p) {
        loadProducts();
        return true;
      },
    );
  }

  Future<bool> deleteProduct(String id) async {
    final result = await _repository.deleteProduct(id);
    return result.fold(
      (error) => false,
      (_) {
        loadProducts();
        return true;
      },
    );
  }
}

/// Provider for ProductsNotifier
final productsNotifierProvider = StateNotifierProvider<ProductsNotifier,
    AsyncValue<List<ProductResponseDTO>>>((ref) {
  final repository = ref.watch(productRepositoryProvider);
  return ProductsNotifier(repository);
});

/// Provider for a single product by id
final productByIdProvider =
    FutureProvider.family<SingleProductResponseDTO?, String>((ref, id) async {
  final repository = ref.watch(productRepositoryProvider);
  final result = await repository.getProductById(id);
  return result.fold<SingleProductResponseDTO>(
    (error) => throw Exception(error),
    (product) {
      if (product != null) {
        return product;
      } else {
        throw Exception('Product not found');
      }
    },
  );
});

/// Notifier for managing categories
class ProductCategoriesNotifier
    extends StateNotifier<AsyncValue<List<ProductCategory>>> {
  final ProductRepository _repository;

  ProductCategoriesNotifier(this._repository)
      : super(const AsyncValue.loading()) {
    loadCategories();
  }

  Future<void> loadCategories() async {
    state = const AsyncValue.loading();
    final result = await _repository.getAllCategories();
    result.fold(
      (error) => state = AsyncValue.error(error, StackTrace.current),
      (categories) => state = AsyncValue.data(categories),
    );
  }

  Future<bool> addCategory(ProductCategory category) async {
    final result = await _repository.createCategory(category);
    return result.fold(
      (error) => false,
      (c) {
        loadCategories();
        return true;
      },
    );
  }

  Future<bool> updateCategory(ProductCategory category) async {
    final result = await _repository.updateCategory(category.id, category);
    return result.fold(
      (error) => false,
      (c) {
        loadCategories();
        return true;
      },
    );
  }

  Future<bool> deleteCategory(String id) async {
    final result = await _repository.deleteCategory(id);
    return result.fold(
      (error) => false,
      (_) {
        loadCategories();
        return true;
      },
    );
  }
}

/// Provider for ProductCategoriesNotifier
final productCategoriesNotifierProvider = StateNotifierProvider<
    ProductCategoriesNotifier, AsyncValue<List<ProductCategory>>>((ref) {
  final repository = ref.watch(productRepositoryProvider);
  return ProductCategoriesNotifier(repository);
});

/// Search filter state
class ProductFilterState {
  final String searchQuery;
  final String? categoryId;
  final bool? isActive;

  const ProductFilterState({
    this.searchQuery = '',
    this.categoryId,
    this.isActive,
  });

  ProductFilterState copyWith({
    String? searchQuery,
    String? categoryId,
    bool? isActive,
  }) {
    return ProductFilterState(
      searchQuery: searchQuery ?? this.searchQuery,
      categoryId: categoryId ?? this.categoryId,
      isActive: isActive ?? this.isActive,
    );
  }
}

/// Provider for product filter state
final productFilterProvider = StateProvider<ProductFilterState>((ref) {
  return const ProductFilterState();
});

/// Provider for filtered products
final filteredProductsProvider =
    Provider<AsyncValue<List<ProductResponseDTO>>>((ref) {
  final productsAsync = ref.watch(productsNotifierProvider);
  final filter = ref.watch(productFilterProvider);

  return productsAsync.whenData((products) {
    var filtered = products;

    if (filter.searchQuery.isNotEmpty) {
      final query = filter.searchQuery.toLowerCase();
      filtered = filtered.where((p) {
        return p.name.toLowerCase().contains(query) ||
            (p.description?.toLowerCase().contains(query) ?? false);
      }).toList();
    }

    if (filter.isActive != null) {
      filtered = filtered.where((p) => p.isActive == filter.isActive).toList();
    }

    return filtered;
  });
});
