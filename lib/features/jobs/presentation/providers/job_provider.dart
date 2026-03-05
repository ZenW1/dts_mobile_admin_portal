import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../generated_code/swagger.swagger.dart';
import '../../domain/repositories/job_repository.dart';
import '../../data/repositories/job_repository_impl.dart';

/// Provider for JobRepository
final jobRepositoryProvider = Provider<JobRepository>((ref) {
  return JobRepositoryImpl();
});

/// Provider for all jobs
final jobsProvider = FutureProvider<GetAllCareersResponseDTO>((ref) async {
  final repository = ref.watch(jobRepositoryProvider);
  return repository.getAllJobs();
});

/// Provider for a single job by id
final jobByIdProvider =
    FutureProvider.family<CareerResponseDTO?, String>((ref, id) async {
  final repository = ref.watch(jobRepositoryProvider);
  return repository.getJobById(id);
});

/// Notifier for managing jobs CRUD operations
class JobsNotifier extends StateNotifier<AsyncValue<GetAllCareersResponseDTO>> {
  final JobRepository _repository;

  JobsNotifier(this._repository) : super(const AsyncValue.loading()) {
    loadJobs();
  }

  Future<void> loadJobs() async {
    state = const AsyncValue.loading();
    try {
      final jobs = await _repository.getAllJobs();
      state = AsyncValue.data(jobs);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> addJob(CreateCareerDTO job) async {
    try {
      await _repository.createJob(job);
      await loadJobs();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateJob(String id, CreateCareerDTO job) async {
    try {
      await _repository.updateJob(id, job);
      await loadJobs();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteJob(String id) async {
    try {
      await _repository.deleteJob(id);
      await loadJobs();
    } catch (e) {
      rethrow;
    }
  }
}

/// Provider for JobsNotifier
final jobsNotifierProvider =
    StateNotifierProvider<JobsNotifier, AsyncValue<GetAllCareersResponseDTO>>(
        (ref) {
  final repository = ref.watch(jobRepositoryProvider);
  return JobsNotifier(repository);
});

/// Filter statex for jobs
class JobFilterState {
  final String searchQuery;
  final bool? isActive;
  final String? type;

  const JobFilterState({
    this.searchQuery = '',
    this.isActive,
    this.type,
  });

  JobFilterState copyWith({
    String? searchQuery,
    bool? isActive,
    String? type,
  }) {
    return JobFilterState(
      searchQuery: searchQuery ?? this.searchQuery,
      isActive: isActive ?? this.isActive,
      type: type ?? this.type,
    );
  }
}

/// Provider for job filter state
final jobFilterProvider = StateProvider<JobFilterState>((ref) {
  return const JobFilterState();
});

/// Provider for filtered jobs
final filteredJobsProvider = Provider<AsyncValue<List<CareerResponseDTO>>>((ref) {
  final jobsAsync = ref.watch(jobsNotifierProvider);
  final filter = ref.watch(jobFilterProvider);


  return jobsAsync.whenData((jobs) {
    var filtered = jobs.data;

    if (filter.searchQuery.isNotEmpty) {
      final query = filter.searchQuery.toLowerCase();
      filtered = filtered.where((j) {
        return j.title?.toLowerCase().contains(query) ?? false ||
            ( j.description != null && j.description!.toLowerCase().contains(query)  )||
            (j.location?.toLowerCase().contains(query) ?? false);
      }).toList();
    }

    if (filter.isActive != null) {
      filtered = filtered.where((j) => j.isActive == filter.isActive).toList();
    }

    if (filter.type != null) {
      filtered = filtered.where((j) => j.type == filter.type).toList();
    }

    return filtered;
  });
});
