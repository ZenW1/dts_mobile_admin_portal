import '../entities/product.dart';
import '../entities/product_category.dart';

/// Product repository interface
abstract class ProductRepository {
  /// Get all products
  Future<List<Product>> getAllProducts();

  /// Get product by id
  Future<Product?> getProductById(String id);

  /// Get products by category
  Future<List<Product>> getProductsByCategory(String categoryId);

  /// Create a new product
  Future<Product> createProduct(Product product);

  /// Update an existing product
  Future<Product> updateProduct(Product product);

  /// Delete a product
  Future<void> deleteProduct(String id);

  /// Get all categories
  Future<List<ProductCategory>> getAllCategories();

  /// Get category by id
  Future<ProductCategory?> getCategoryById(String id);

  /// Create a new category
  Future<ProductCategory> createCategory(ProductCategory category);

  /// Update an existing category
  Future<ProductCategory> updateCategory(ProductCategory category);

  /// Delete a category
  Future<void> deleteCategory(String id);
}
