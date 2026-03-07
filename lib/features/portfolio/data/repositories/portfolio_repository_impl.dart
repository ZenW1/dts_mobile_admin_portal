import 'package:logger/logger.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../generated_code/swagger.swagger.dart';
import '../../domain/repositories/portfolio_repository.dart';

/// Implementation of PortfolioRepository with API integration
class PortfolioRepositoryImpl implements PortfolioRepository {
  final Swagger _api;
  final Logger _logger;

  PortfolioRepositoryImpl()
      : _api = ApiServiceProvider().restApi,
        _logger = Logger();

  @override
  Future<GetAllPortfoliosResponseDTO> getAllPortfolios() async {
    try {
      final response = await _api.GetAllPortfolios();
      if (response.body != null) {
        return response.body ?? GetAllPortfoliosResponseDTO(data: []);
      }
      throw Exception('Failed to get all portfolios: ${response.error}');
    } catch (e) {
      _logger.e('Error getting all portfolios: $e');
      rethrow;
    }
  }

  @override
  Future<GetPortfolioDetailResponseDTO?> getPortfolioById(String id) async {
    try {
      final response = await _api.GetPortfolioById(portfolioId: id);
      if (response.isSuccessful && response.body != null) {
        return response.body!;
      }
      return null;
    } catch (e) {
      _logger.e('Error getting portfolio by id: $e');
      return null;
    }
  }

  @override
  Future<List<PortfolioResponseDTO>> getPortfoliosByCategory(
      String categoryId) async {
    try {
      final all = await getAllPortfolios();
      return all.data.where((p) => p.category?.id == categoryId).toList();
    } catch (e) {
      _logger.e('Error getting portfolios by category: $e');
      rethrow;
    }
  }

  @override
  Future<GetAllPortfoliosResponseDTO> getFeaturedPortfolios() async {
    try {
      final all = await getAllPortfolios();
      final featured = all.data.where((p) => p.isActive == true).toList();
      return GetAllPortfoliosResponseDTO(data: featured);
    } catch (e) {
      _logger.e('Error getting featured portfolios: $e');
      rethrow;
    }
  }

  @override
  Future<void> createPortfolio(CreatePortfolioDTO dto) async {
    try {
      await _api.CreatePortfolio(body: dto);
    } on TypeError catch (e) {
      if (e.toString().contains('is not a subtype of type')) {
        _logger.w('API create succeeded but parsing failed: $e');
        rethrow;
      }
      rethrow;
    } catch (e) {
      _logger.e('Error creating portfolio: $e');
      rethrow;
    }
  }

  @override
  Future<UpdatePortfolioResponseDTO> updatePortfolio(
      String id, CreatePortfolioDTO dto) async {
    try {
      final response = await _api.UpdatePortfolio(
        portfolioId: id,
        body: dto,
      );
      if (response.isSuccessful && response.body != null) {
        return response.body!;
      }
      throw Exception('Failed to update portfolio: ${response.error}');
    } on TypeError catch (e) {
      if (e.toString().contains('is not a subtype of type')) {
        _logger.w('API update succeeded but parsing failed: $e');
        rethrow;
      }
      rethrow;
    } catch (e) {
      _logger.e('Error updating portfolio: $e');
      rethrow;
    }
  }

  @override
  Future<void> deletePortfolio(String id) async {
    try {
      final response = await _api.DeletePortfolio(portfolioId: id);
      if (!response.isSuccessful) {
        throw Exception('Failed to delete portfolio: ${response.error}');
      }
    } catch (e) {
      _logger.e('Error deleting portfolio: $e');
      rethrow;
    }
  }

  @override
  Future<GetAllPortfolioCategoriesResponseDTO> getAllCategories() async {
    try {
      final response = await _api.GetAllPortfolioCategories();
      if (response.body != null) {
        return response.body!;
      }
      throw Exception('Failed to get all categories: ${response.error}');
    } catch (e) {
      _logger.e('Error getting all categories: $e');
      rethrow;
    }
  }

  @override
  Future<PortfolioCategoryResponseDTO?> getCategoryById(String id) async {
    try {
      final response = await _api.GetPortfolioCategoryById(id: id);
      if (response.isSuccessful && response.body != null) {
        return response.body!;
      }
      return null;
    } catch (e) {
      _logger.e('Error getting category by id: $e');
      return null;
    }
  }

  @override
  Future<PortfolioCategoryResponseDTO> createCategory(
      CreatePortfolioCategoryDTO dto) async {
    try {
      final response = await _api.CreatePortfolioCategory(body: dto);
      if (response.isSuccessful && response.body != null) {
        return response.body!;
      }
      throw Exception('Failed to create category: ${response.error}');
    } on TypeError catch (e) {
      if (e.toString().contains('is not a subtype of type')) {
        _logger.w('API create succeeded but parsing failed: $e');
        rethrow;
      }
      rethrow;
    } catch (e) {
      _logger.e('Error creating category: $e');
      rethrow;
    }
  }

  @override
  Future<PortfolioCategoryResponseDTO> updateCategory(
      String id, CreatePortfolioCategoryDTO dto) async {
    try {
      final response = await _api.UpdatePortfolioCategory(
        id: id,
        body: dto,
      );
      if (response.isSuccessful && response.body != null) {
        return response.body!;
      }
      throw Exception('Failed to update category: ${response.error}');
    } on TypeError catch (e) {
      if (e.toString().contains('is not a subtype of type')) {
        _logger.w('API update succeeded but parsing failed: $e');
        rethrow;
      }
      rethrow;
    } catch (e) {
      _logger.e('Error updating category: $e');
      rethrow;
    }
  }

  @override
  Future<void> deleteCategory(String id) async {
    try {
      final response = await _api.DeletePortfolioCategory(id: id);
      if (!response.isSuccessful) {
        throw Exception('Failed to delete category: ${response.error}');
      }
    } catch (e) {
      _logger.e('Error deleting category: $e');
      rethrow;
    }
  }
}
