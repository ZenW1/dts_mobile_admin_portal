import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/product.dart';
import '../../domain/entities/product_category.dart';
import '../../domain/repositories/product_repository.dart';
import '../../data/repositories/product_repository_impl.dart';

/// Provider for ProductRepository
final productRepositoryProvider = Provider<ProductRepository>((ref) {
  return ProductRepositoryImpl();
});

/// Provider for all products
final productsProvider = FutureProvider<List<Product>>((ref) async {
  final repository = ref.watch(productRepositoryProvider);
  return repository.getAllProducts();
});

/// Provider for a single product by id
final productByIdProvider =
    FutureProvider.family<Product?, String>((ref, id) async {
  final repository = ref.watch(productRepositoryProvider);
  return repository.getProductById(id);
});

/// Provider for all categories
final productCategoriesProvider =
    FutureProvider<List<ProductCategory>>((ref) async {
  final repository = ref.watch(productRepositoryProvider);
  return repository.getAllCategories();
});

/// Provider for a single category by id
final productCategoryByIdProvider =
    FutureProvider.family<ProductCategory?, String>((ref, id) async {
  final repository = ref.watch(productRepositoryProvider);
  return repository.getCategoryById(id);
});

/// Notifier for managing products CRUD operations
class ProductsNotifier extends StateNotifier<AsyncValue<List<Product>>> {
  final ProductRepository _repository;

  ProductsNotifier(this._repository) : super(const AsyncValue.loading()) {
    loadProducts();
  }

  Future<void> loadProducts() async {
    state = const AsyncValue.loading();
    try {
      final products = await _repository.getAllProducts();
      state = AsyncValue.data(products);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> addProduct(Product product) async {
    try {
      await _repository.createProduct(product);
      await loadProducts();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateProduct(Product product) async {
    try {
      await _repository.updateProduct(product);
      await loadProducts();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteProduct(String id) async {
    try {
      await _repository.deleteProduct(id);
      await loadProducts();
    } catch (e) {
      rethrow;
    }
  }
}

/// Provider for ProductsNotifier
final productsNotifierProvider =
    StateNotifierProvider<ProductsNotifier, AsyncValue<List<Product>>>((ref) {
  final repository = ref.watch(productRepositoryProvider);
  return ProductsNotifier(repository);
});

/// Notifier for managing categories CRUD operations
class ProductCategoriesNotifier
    extends StateNotifier<AsyncValue<List<ProductCategory>>> {
  final ProductRepository _repository;

  ProductCategoriesNotifier(this._repository)
      : super(const AsyncValue.loading()) {
    loadCategories();
  }

  Future<void> loadCategories() async {
    state = const AsyncValue.loading();
    try {
      final categories = await _repository.getAllCategories();
      state = AsyncValue.data(categories);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> addCategory(ProductCategory category) async {
    try {
      await _repository.createCategory(category);
      await loadCategories();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateCategory(ProductCategory category) async {
    try {
      await _repository.updateCategory(category);
      await loadCategories();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteCategory(String id) async {
    try {
      await _repository.deleteCategory(id);
      await loadCategories();
    } catch (e) {
      rethrow;
    }
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
final filteredProductsProvider = Provider<AsyncValue<List<Product>>>((ref) {
  final productsAsync = ref.watch(productsNotifierProvider);
  final filter = ref.watch(productFilterProvider);

  return productsAsync.whenData((products) {
    var filtered = products;

    // Filter by search query
    if (filter.searchQuery.isNotEmpty) {
      final query = filter.searchQuery.toLowerCase();
      filtered = filtered.where((p) {
        return p.name.toLowerCase().contains(query) ||
            (p.description?.toLowerCase().contains(query) ?? false);
      }).toList();
    }

    // Filter by category
    if (filter.categoryId != null) {
      filtered =
          filtered.where((p) => p.categoryId == filter.categoryId).toList();
    }

    // Filter by active status
    if (filter.isActive != null) {
      filtered = filtered.where((p) => p.isActive == filter.isActive).toList();
    }

    return filtered;
  });
});
