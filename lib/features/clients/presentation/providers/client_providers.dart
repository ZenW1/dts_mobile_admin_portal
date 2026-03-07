import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/dio_client.dart';
import '../../../../generated_code/swagger.swagger.dart';
import '../../domain/entities/client.dart';
import '../../data/client_repository.dart';
import '../../data/client_repository_impl.dart';

/// Provider for ClientRepository
final clientRepositoryProvider = Provider<ClientRepository>((ref) {
  return ClientRepositoryImpl(ApiServiceProvider().restApi);
});

/// Filter state for client list
class ClientFilterState {
  final String searchQuery;
  final ClientStatus? status;
  final String? sortBy;
  final String? sortOrder;
  final int page;
  final int limit;

  const ClientFilterState({
    this.searchQuery = '',
    this.status,
    this.sortBy,
    this.sortOrder,
    this.page = 1,
    this.limit = 20,
  });

  ClientFilterState copyWith({
    String? searchQuery,
    ClientStatus? status,
    String? sortBy,
    String? sortOrder,
    int? page,
    int? limit,
    bool clearStatus = false,
    bool clearSortBy = false,
    bool clearSortOrder = false,
  }) {
    return ClientFilterState(
      searchQuery: searchQuery ?? this.searchQuery,
      status: clearStatus ? null : (status ?? this.status),
      sortBy: clearSortBy ? null : (sortBy ?? this.sortBy),
      sortOrder: clearSortOrder ? null : (sortOrder ?? this.sortOrder),
      page: page ?? this.page,
      limit: limit ?? this.limit,
    );
  }
}

/// Provider for client filter state
final clientFilterProvider = StateProvider<ClientFilterState>((ref) {
  return const ClientFilterState();
});

/// Notifier for managing client list and pagination
class ClientListNotifier extends StateNotifier<AsyncValue<List<Client>>> {
  final ClientRepository _repository;
  final Ref _ref;
  bool _hasMore = true;

  bool get hasMore => _hasMore;

  ClientListNotifier(this._repository, this._ref)
      : super(const AsyncValue.loading()) {
    _ref.listen<ClientFilterState>(clientFilterProvider, (previous, next) {
      if (previous?.searchQuery != next.searchQuery ||
          previous?.status != next.status ||
          previous?.sortBy != next.sortBy ||
          previous?.sortOrder != next.sortOrder) {
        // Reset page to 1 when filters change
        _ref.read(clientFilterProvider.notifier).state = next.copyWith(page: 1);
        loadClients(refresh: true);
      } else if (previous?.page != next.page && next.page > 1) {
        // Load next page
        loadClients();
      }
    });

    loadClients(refresh: true);
  }

  Future<void> loadClients({bool refresh = false}) async {
    final filter = _ref.read(clientFilterProvider);

    if (refresh) {
      state = const AsyncValue.loading();
      _hasMore = true;
    }

    if (!_hasMore && !refresh) return;

    try {
      final result = filter.searchQuery.isNotEmpty
          ? await _repository.searchClients(
              query: filter.searchQuery,
              status: filter.status,
              sortBy: filter.sortBy,
              sortOrder: filter.sortOrder,
              page: filter.page,
              limit: filter.limit,
            )
          : await _repository.getClients(
              status: filter.status,
              sortBy: filter.sortBy,
              sortOrder: filter.sortOrder,
              page: filter.page,
              limit: filter.limit,
            );

      result.fold(
        (error) => state = AsyncValue.error(error, StackTrace.current),
        (clients) {
          _hasMore = clients.length == filter.limit;
          if (refresh) {
            state = AsyncValue.data(clients);
          } else {
            final currentList = state.value ?? [];
            state = AsyncValue.data([...currentList, ...clients]);
          }
        },
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> refresh() async {
    _ref.read(clientFilterProvider.notifier).state =
        _ref.read(clientFilterProvider).copyWith(page: 1);
    await loadClients(refresh: true);
  }
}

/// Provider for ClientListNotifier
final clientListProvider =
    StateNotifierProvider<ClientListNotifier, AsyncValue<List<Client>>>((ref) {
  final repository = ref.watch(clientRepositoryProvider);
  return ClientListNotifier(repository, ref);
});

/// Provider for a single client by id
final clientDetailProvider =
    FutureProvider.family<Client?, String>((ref, id) async {
  final repository = ref.watch(clientRepositoryProvider);
  final result = await repository.getClientById(id);

  return result.fold(
    (error) => throw Exception(error),
    (client) => client,
  );
});

/// Notifier for managing client mutations (create, update, delete)
class ClientMutationsNotifier extends StateNotifier<AsyncValue<void>> {
  final ClientRepository _repository;
  final Ref _ref;

  ClientMutationsNotifier(this._repository, this._ref)
      : super(const AsyncValue.data(null));

  Future<Client?> createClient(CreateClientDTO client) async {
    state = const AsyncValue.loading();
    final result = await _repository.createClient(client);

    return result.fold(
      (error) {
        state = AsyncValue.error(error, StackTrace.current);
        return null;
      },
      (client) {
        state = const AsyncValue.data(null);
        _ref.read(clientListProvider.notifier).refresh();
        return client;
      },
    );
  }

  Future<Client?> updateClient(String id, UpdateClientDTO client) async {
    state = const AsyncValue.loading();
    final result = await _repository.updateClient(id, client);

    return result.fold(
      (error) {
        state = AsyncValue.error(error, StackTrace.current);
        return null;
      },
      (client) {
        state = const AsyncValue.data(null);
        _ref.invalidate(clientDetailProvider(id));
        _ref.read(clientListProvider.notifier).refresh();
        return client;
      },
    );
  }

  Future<void> deleteClient(String id) async {
    state = const AsyncValue.loading();
    final result = await _repository.deleteClient(id);

    result.fold(
      (error) => state = AsyncValue.error(error, StackTrace.current),
      (success) {
        state = const AsyncValue.data(null);
        _ref.read(clientListProvider.notifier).refresh();
      },
    );
  }

  Future<void> uploadImage(String id, File imageFile) async {
    state = const AsyncValue.loading();
    final result = await _repository.uploadImage(id, imageFile);

    result.fold(
      (error) => state = AsyncValue.error(error, StackTrace.current),
      (success) {
        state = const AsyncValue.data(null);
        _ref.invalidate(clientDetailProvider(id));
        _ref.read(clientListProvider.notifier).refresh();
      },
    );
  }

  Future<void> removeImage(String id) async {
    state = const AsyncValue.loading();
    final result = await _repository.removeImage(id);

    result.fold(
      (error) => state = AsyncValue.error(error, StackTrace.current),
      (success) {
        state = const AsyncValue.data(null);
        _ref.invalidate(clientDetailProvider(id));
        _ref.read(clientListProvider.notifier).refresh();
      },
    );
  }
}

/// Provider for ClientMutationsNotifier
final clientMutationsProvider =
    StateNotifierProvider<ClientMutationsNotifier, AsyncValue<void>>((ref) {
  final repository = ref.watch(clientRepositoryProvider);
  return ClientMutationsNotifier(repository, ref);
});
