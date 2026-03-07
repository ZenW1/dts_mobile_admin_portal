import '../../../../generated_code/swagger.swagger.dart';

/// Portfolio repository interface using Swagger DTOs directly
abstract class PortfolioRepository {
  /// Get all portfolio items
  Future<GetAllPortfoliosResponseDTO> getAllPortfolios();

  /// Get portfolio by id
  Future<GetPortfolioDetailResponseDTO?> getPortfolioById(String id);

  /// Get portfolios by category
  Future<List<PortfolioResponseDTO>> getPortfoliosByCategory(String categoryId);

  /// Get featured portfolios
  Future<GetAllPortfoliosResponseDTO> getFeaturedPortfolios();

  /// Create a new portfolio
  Future<void> createPortfolio(CreatePortfolioDTO dto);

  /// Update an existing portfolio
  Future<UpdatePortfolioResponseDTO> updatePortfolio(
      String id, CreatePortfolioDTO dto);

  /// Delete a portfolio
  Future<void> deletePortfolio(String id);

  /// Get all categories
  Future<GetAllPortfolioCategoriesResponseDTO> getAllCategories();

  /// Get category by id
  Future<PortfolioCategoryResponseDTO?> getCategoryById(String id);

  /// Create a new category
  Future<PortfolioCategoryResponseDTO> createCategory(
      CreatePortfolioCategoryDTO dto);

  /// Update an existing category
  Future<PortfolioCategoryResponseDTO> updateCategory(
      String id, CreatePortfolioCategoryDTO dto);

  /// Delete a category
  Future<void> deleteCategory(String id);
}
