import 'package:dts_admin_portal/generated_code/swagger.swagger.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/team_member.dart';
import '../../domain/repositories/team_repository.dart';
import '../../data/repositories/team_repository_impl.dart';

/// Provider for TeamRepository
final teamRepositoryProvider = Provider<TeamRepository>((ref) {
  return TeamRepositoryImpl();
});

/// Provider for all team members
final allTeamsProvider = FutureProvider<GetAllTeamsResponseDTO>((ref) async {
  final repository = ref.watch(teamRepositoryProvider);
  return repository.getAllTeams();
});

final memberProvider = FutureProvider.family<SingleTeamResponseDTO, String>((ref, id) async {
  final teamRepository = ref.watch(teamRepositoryProvider);
  return teamRepository.getTeamById(id);
});


/// Team state for CRUD operations
class TeamState {
  final bool isLoading;
  final String? error;
  final bool isSuccess;

  const TeamState({
    this.isLoading = false,
    this.error,
    this.isSuccess = false,
  });

  TeamState copyWith({
    bool? isLoading,
    String? error,
    bool? isSuccess,
  }) {
    return TeamState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}

/// Notifier for managing team CRUD operations
class TeamNotifier extends StateNotifier<TeamState> {
  final TeamRepository _repository;
  final Ref _ref;

  TeamNotifier(this._repository, this._ref) : super(const TeamState());

  Future<void> createMember(CreateTeamDTO member) async {
    state = state.copyWith(isLoading: true, error: null, isSuccess: false);
    try {
      await _repository.createTeam(member);
      state = state.copyWith(isLoading: false, isSuccess: true);
      _ref.invalidate(allTeamsProvider);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }


  Future<void> updateMember(CreateTeamDTO member,String memberId) async {
    state = state.copyWith(isLoading: true, error: null, isSuccess: false);
    try {
      await _repository.updateTeam(member, memberId);
      state = state.copyWith(isLoading: false, isSuccess: true);
      _ref.invalidate(allTeamsProvider);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> deleteMember(String id) async {
    state = state.copyWith(isLoading: true, error: null, isSuccess: false);
    try {
      await _repository.deleteTeam(id);
      state = state.copyWith(isLoading: false, isSuccess: true);
      _ref.invalidate(allTeamsProvider);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void reset() {
    state = const TeamState();
  }
}

/// Provider for TeamNotifier
final teamNotifierProvider =
    StateNotifierProvider<TeamNotifier, TeamState>((ref) {
  final repository = ref.watch(teamRepositoryProvider);
  return TeamNotifier(repository, ref);
});

/// Filter state for team list
class TeamFilterState {
  final String searchQuery;
  final String? role;
  final bool? isActive;

  const TeamFilterState({
    this.searchQuery = '',
    this.role,
    this.isActive,
  });

  TeamFilterState copyWith({
    String? searchQuery,
    String? role,
    bool? isActive,
    bool clearRole = false,
  }) {
    return TeamFilterState(
      searchQuery: searchQuery ?? this.searchQuery,
      role: clearRole ? null : (role ?? this.role),
      isActive: isActive ?? this.isActive,
    );
  }
}

/// Provider for team filter state
final teamFilterProvider = StateProvider<TeamFilterState>((ref) {
  return const TeamFilterState();
});

/// Provider for filtered teams
final filteredTeamsProvider = Provider<AsyncValue<List<TeamResponseDTO>>>((ref) {
  final teamsAsync = ref.watch(allTeamsProvider);
  final filter = ref.watch(teamFilterProvider);

  return teamsAsync.whenData((teams) {
    var filtered = teams.data;

    // Filter by search query (name)
    if (filter.searchQuery.isNotEmpty) {
      final query = filter.searchQuery.toLowerCase();
      filtered =
          filtered.where((m) => m.name.toLowerCase().contains(query)).toList();
    }

    // Filter by role
    if (filter.role != null) {
      filtered = filtered.where((m) => m.role == filter.role).toList();
    }

    // Filter by active status
    if (filter.isActive != null) {
      filtered = filtered.where((m) => m.isActive == filter.isActive).toList();
    }

    return filtered;
  });
});
