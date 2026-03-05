import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dts_admin_portal/generated_code/swagger.swagger.dart';
import '../../domain/repositories/portfolio_repository.dart';
import '../../data/repositories/portfolio_repository_impl.dart';

/// Provider for PortfolioRepository
final portfolioRepositoryProvider = Provider<PortfolioRepository>((ref) {
  return PortfolioRepositoryImpl();
});

/// Provider for all portfolios
final portfoliosProvider =
    FutureProvider<GetAllPortfoliosResponseDTO>((ref) async {
  final repository = ref.watch(portfolioRepositoryProvider);
  return repository.getAllPortfolios();
});

/// Provider for a single portfolio by id
final portfolioByIdProvider =
    FutureProvider.family<GetPortfolioDetailResponseDTO?, String>((ref, id) async {
  final repository = ref.watch(portfolioRepositoryProvider);
  return repository.getPortfolioById(id);
});

/// Provider for featured portfolios
final featuredPortfoliosProvider =
    FutureProvider<GetAllPortfoliosResponseDTO>((ref) async {
  final repository = ref.watch(portfolioRepositoryProvider);
  return repository.getFeaturedPortfolios();
});

/// Provider for all categories
final portfolioCategoriesProvider =
    FutureProvider<GetAllPortfolioCategoriesResponseDTO>((ref) async {
  final repository = ref.watch(portfolioRepositoryProvider);
  return repository.getAllCategories();
});

/// Notifier for managing portfolio CRUD operations
class PortfoliosNotifier
    extends StateNotifier<AsyncValue<GetAllPortfoliosResponseDTO>> {
  final PortfolioRepository _repository;

  PortfoliosNotifier(this._repository) : super(const AsyncValue.loading()) {
    loadPortfolios();
  }

  Future<void> loadPortfolios() async {
    state = const AsyncValue.loading();
    try {
      final portfolios = await _repository.getAllPortfolios();
      state = AsyncValue.data(portfolios);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> addPortfolio(CreatePortfolioDTO dto) async {
    try {
      await _repository.createPortfolio(dto);
      await loadPortfolios();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updatePortfolio(String id, CreatePortfolioDTO dto) async {
    try {
      await _repository.updatePortfolio(id, dto);
      await loadPortfolios();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deletePortfolio(String id) async {
    try {
      await _repository.deletePortfolio(id);
      await loadPortfolios();
    } catch (e) {
      rethrow;
    }
  }
}

/// Provider for PortfoliosNotifier
final portfoliosNotifierProvider = StateNotifierProvider<PortfoliosNotifier,
    AsyncValue<GetAllPortfoliosResponseDTO>>((ref) {
  final repository = ref.watch(portfolioRepositoryProvider);
  return PortfoliosNotifier(repository);
});

/// Notifier for managing category CRUD operations
class PortfolioCategoriesNotifier
    extends StateNotifier<AsyncValue<List<PortfolioCategoryResponseDTO>>> {
  final PortfolioRepository _repository;

  PortfolioCategoriesNotifier(this._repository)
      : super(const AsyncValue.loading()) {
    loadCategories();
  }

  Future<void> loadCategories() async {
    state = const AsyncValue.loading();
    try {
      final categories = await _repository.getAllCategories();
      state = AsyncValue.data(categories.data);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> addCategory(CreatePortfolioCategoryDTO dto) async {
    try {
      await _repository.createCategory(dto);
      await loadCategories();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateCategory(String id, CreatePortfolioCategoryDTO dto) async {
    try {
      await _repository.updateCategory(id, dto);
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

/// Provider for PortfolioCategoriesNotifier
final portfolioCategoriesNotifierProvider = StateNotifierProvider<
    PortfolioCategoriesNotifier,
    AsyncValue<List<PortfolioCategoryResponseDTO>>>((ref) {
  final repository = ref.watch(portfolioRepositoryProvider);
  return PortfolioCategoriesNotifier(repository);
});

/// Filter state for portfolios
class PortfolioFilterState {
  final String searchQuery;
  final String? categoryId;
  final bool? isActive;

  const PortfolioFilterState({
    this.searchQuery = '',
    this.categoryId,
    this.isActive,
  });

  PortfolioFilterState copyWith({
    String? searchQuery,
    String? categoryId,
    bool? isActive,
  }) {
    return PortfolioFilterState(
      searchQuery: searchQuery ?? this.searchQuery,
      categoryId: categoryId ?? this.categoryId,
      isActive: isActive ?? this.isActive,
    );
  }
}

/// Provider for portfolio filter state
final portfolioFilterProvider = StateProvider<PortfolioFilterState>((ref) {
  return const PortfolioFilterState();
});

/// Provider for filtered portfolios
final filteredPortfoliosProvider =
    Provider<AsyncValue<List<PortfolioResponseDTO>>>((ref) {
  final portfoliosAsync = ref.watch(portfoliosNotifierProvider);
  final filter = ref.watch(portfolioFilterProvider);

  return portfoliosAsync.whenData((response) {
    var filtered = response.data;

    if (filter.searchQuery.isNotEmpty) {
      final query = filter.searchQuery.toLowerCase();
      filtered = filtered.where((p) {
        return p.title.toLowerCase().contains(query) ||
            (p.description.toLowerCase().contains(query)) ||
            (p.$client?.toLowerCase().contains(query) ?? false);
      }).toList();
    }

    if (filter.categoryId != null) {
      filtered =
          filtered.where((p) => p.category?.id == filter.categoryId).toList();
    }

    if (filter.isActive != null) {
      filtered = filtered.where((p) => p.isActive == filter.isActive).toList();
    }

    return filtered;
  });
});
