import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/customer_feedback.dart';
import '../../domain/entities/feedback_stats.dart';
import '../../domain/repositories/feedback_repository.dart';
import '../../data/repositories/feedback_repository_impl.dart';

/// Provider for FeedbackRepository
final feedbackRepositoryProvider = Provider<FeedbackRepository>((ref) {
  return FeedbackRepositoryImpl();
});

/// Provider for all feedback
final allFeedbackProvider = FutureProvider<List<CustomerFeedback>>((ref) async {
  final repository = ref.watch(feedbackRepositoryProvider);
  return repository.getAllFeedback();
});

/// Provider for a single feedback by id
final feedbackByIdProvider =
    FutureProvider.family<CustomerFeedback?, String>((ref, id) async {
  final repository = ref.watch(feedbackRepositoryProvider);
  return repository.getFeedbackById(id);
});

/// Provider for feedback stats
final feedbackStatsProvider = FutureProvider<FeedbackStats>((ref) async {
  final repository = ref.watch(feedbackRepositoryProvider);
  return repository.getFeedbackStats();
});

/// Notifier for managing feedback CRUD operations
class FeedbackNotifier
    extends StateNotifier<AsyncValue<List<CustomerFeedback>>> {
  final FeedbackRepository _repository;

  FeedbackNotifier(this._repository) : super(const AsyncValue.loading()) {
    loadFeedbacks();
  }

  Future<void> loadFeedbacks() async {
    state = const AsyncValue.loading();
    try {
      final feedbacks = await _repository.getAllFeedback();
      state = AsyncValue.data(feedbacks);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> addFeedback(CustomerFeedback feedback) async {
    try {
      await _repository.createFeedback(feedback);
      await loadFeedbacks();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateFeedback(CustomerFeedback feedback) async {
    try {
      await _repository.updateFeedback(feedback);
      await loadFeedbacks();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteFeedback(String id) async {
    try {
      await _repository.deleteFeedback(id);
      await loadFeedbacks();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateStatus(String id, FeedbackStatus status) async {
    try {
      await _repository.updateStatus(id, status);
      await loadFeedbacks();
    } catch (e) {
      rethrow;
    }
  }
}

/// Provider for FeedbackNotifier
final feedbackNotifierProvider =
    StateNotifierProvider<FeedbackNotifier, AsyncValue<List<CustomerFeedback>>>(
        (ref) {
  final repository = ref.watch(feedbackRepositoryProvider);
  return FeedbackNotifier(repository);
});

/// Notifier for managing feedback stats
class FeedbackStatsNotifier extends StateNotifier<AsyncValue<FeedbackStats>> {
  final FeedbackRepository _repository;

  FeedbackStatsNotifier(this._repository) : super(const AsyncValue.loading()) {
    loadStats();
  }

  Future<void> loadStats() async {
    state = const AsyncValue.loading();
    try {
      final stats = await _repository.getFeedbackStats();
      state = AsyncValue.data(stats);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

/// Provider for FeedbackStatsNotifier
final feedbackStatsNotifierProvider =
    StateNotifierProvider<FeedbackStatsNotifier, AsyncValue<FeedbackStats>>(
        (ref) {
  final repository = ref.watch(feedbackRepositoryProvider);
  return FeedbackStatsNotifier(repository);
});

/// Filter state for feedback list
class FeedbackFilterState {
  final String searchQuery;
  final FeedbackStatus? status;
  final bool? isActive;

  const FeedbackFilterState({
    this.searchQuery = '',
    this.status,
    this.isActive,
  });

  FeedbackFilterState copyWith({
    String? searchQuery,
    FeedbackStatus? status,
    bool? isActive,
    bool clearStatus = false,
  }) {
    return FeedbackFilterState(
      searchQuery: searchQuery ?? this.searchQuery,
      status: clearStatus ? null : (status ?? this.status),
      isActive: isActive ?? this.isActive,
    );
  }
}

/// Provider for feedback filter state
final feedbackFilterProvider = StateProvider<FeedbackFilterState>((ref) {
  return const FeedbackFilterState();
});

/// Provider for filtered feedback
final filteredFeedbackProvider =
    Provider<AsyncValue<List<CustomerFeedback>>>((ref) {
  final feedbacksAsync = ref.watch(feedbackNotifierProvider);
  final filter = ref.watch(feedbackFilterProvider);

  return feedbacksAsync.whenData((feedbacks) {
    var filtered = feedbacks;

    // Filter by search query
    if (filter.searchQuery.isNotEmpty) {
      final query = filter.searchQuery.toLowerCase();
      filtered = filtered.where((f) {
        return (f.customerName != null &&
                f.customerName!.toLowerCase().contains(query)) ||
            (f.email != null && f.email!.toLowerCase().contains(query)) ||
            (f.message != null &&  f.message!.toLowerCase().contains(query)) ||
            (f.subject != null && f.subject!.toLowerCase().contains(query));
      }).toList();
    }

    // Filter by status
    if (filter.status != null) {
      filtered = filtered.where((f) => f.status == filter.status).toList();
    }

    // Filter by active status
    if (filter.isActive != null) {
      filtered = filtered.where((f) => f.isActive == filter.isActive).toList();
    }

    return filtered;
  });
});
