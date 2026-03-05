import '../../domain/entities/product.dart';
import '../../domain/entities/product_category.dart';
import '../../domain/repositories/product_repository.dart';
import '../mock/product_mock_data.dart';

/// Implementation of ProductRepository with mock data
class ProductRepositoryImpl implements ProductRepository {
  // In-memory storage for testing
  final List<Product> _products = List.from(ProductMockData.products);
  final List<ProductCategory> _categories =
      List.from(ProductMockData.categories);

  // Simulated API delay
  static const _delay = Duration(milliseconds: 500);

  @override
  Future<List<Product>> getAllProducts() async {
    await Future.delayed(_delay);
    return List.from(_products)
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  @override
  Future<Product?> getProductById(String id) async {
    await Future.delayed(_delay);
    try {
      return _products.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<List<Product>> getProductsByCategory(String categoryId) async {
    await Future.delayed(_delay);
    return _products.where((p) => p.categoryId == categoryId).toList();
  }

  @override
  Future<Product> createProduct(Product product) async {
    await Future.delayed(_delay);
    _products.add(product);
    return product;
  }

  @override
  Future<Product> updateProduct(Product product) async {
    await Future.delayed(_delay);
    final index = _products.indexWhere((p) => p.id == product.id);
    if (index != -1) {
      final updated = product.copyWith(updatedAt: DateTime.now());
      _products[index] = updated;
      return updated;
    }
    throw Exception('Product not found');
  }

  @override
  Future<void> deleteProduct(String id) async {
    await Future.delayed(_delay);
    _products.removeWhere((p) => p.id == id);
  }

  @override
  Future<List<ProductCategory>> getAllCategories() async {
    await Future.delayed(_delay);
    return List.from(_categories)..sort((a, b) => a.name.compareTo(b.name));
  }

  @override
  Future<ProductCategory?> getCategoryById(String id) async {
    await Future.delayed(_delay);
    try {
      return _categories.firstWhere((c) => c.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<ProductCategory> createCategory(ProductCategory category) async {
    await Future.delayed(_delay);
    _categories.add(category);
    return category;
  }

  @override
  Future<ProductCategory> updateCategory(ProductCategory category) async {
    await Future.delayed(_delay);
    final index = _categories.indexWhere((c) => c.id == category.id);
    if (index != -1) {
      final updated = category.copyWith(updatedAt: DateTime.now());
      _categories[index] = updated;
      return updated;
    }
    throw Exception('Category not found');
  }

  @override
  Future<void> deleteCategory(String id) async {
    await Future.delayed(_delay);
    // Check if any products use this category
    final hasProducts = _products.any((p) => p.categoryId == id);
    if (hasProducts) {
      throw Exception('Cannot delete category with existing products');
    }
    _categories.removeWhere((c) => c.id == id);
  }
}
