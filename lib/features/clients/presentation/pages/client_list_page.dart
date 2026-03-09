import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../providers/client_providers.dart';
import '../widgets/client_card.dart';
import '../widgets/client_list_toolbar.dart';

class ClientListPage extends ConsumerStatefulWidget {
  const ClientListPage({super.key});

  @override
  ConsumerState<ClientListPage> createState() => _ClientListPageState();
}

class _ClientListPageState extends ConsumerState<ClientListPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final clientListNotifier = ref.read(clientListProvider.notifier);
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent * 0.9 &&
        clientListNotifier.hasMore &&
        !ref.read(clientListProvider).isLoading) {
      final currentFilter = ref.read(clientFilterProvider);
      ref.read(clientFilterProvider.notifier).state =
          currentFilter.copyWith(page: currentFilter.page + 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final clientsAsync = ref.watch(clientListProvider);
    final filterState = ref.watch(clientFilterProvider);

    return Scaffold(
      backgroundColor:
          isDark ? AppColors.darkBackground : AppColors.lightBackground,
      appBar: AppBar(
        title: const Text('Clients Directory'),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Toolbar
            ClientListToolbar(
              initialSearchQuery: filterState.searchQuery,
              initialStatus: filterState.status,
              onSearchChanged: (query) {
                ref.read(clientFilterProvider.notifier).state =
                    ref.read(clientFilterProvider).copyWith(searchQuery: query);
              },
              onStatusChanged: (status) {
                ref.read(clientFilterProvider.notifier).state = ref
                    .read(clientFilterProvider)
                    .copyWith(status: status, clearStatus: status == null);
              },
              onAddClient: () {
                context.push('/clients/create');
              },
            ),
            const SizedBox(height: AppSpacing.xl),

            // Advanced Sort & Status Info
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Clients List',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: isDark ? AppColors.darkText : AppColors.lightText,
                  ),
                ),
                PopupMenuButton<String>(
                  icon: const Icon(Icons.sort),
                  tooltip: 'Sort By',
                  onSelected: (value) {
                    ref.read(clientFilterProvider.notifier).state = ref
                        .read(clientFilterProvider)
                        .copyWith(
                            sortBy: value,
                            sortOrder:
                                ref.read(clientFilterProvider).sortOrder ==
                                        'asc'
                                    ? 'desc'
                                    : 'asc');
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(value: 'name', child: Text('Name')),
                    const PopupMenuItem(
                        value: 'company', child: Text('Company')),
                    const PopupMenuItem(
                        value: 'totalProjects', child: Text('Total Projects')),
                    const PopupMenuItem(
                        value: 'createdAt', child: Text('Date Added')),
                  ],
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),

            // Grid View
            Expanded(
              child: clientsAsync.when(
                data: (clients) {
                  if (clients.isEmpty) {
                    return _buildEmptyState(context);
                  }

                  // Responsive grid logic
                  final screenWidth = MediaQuery.of(context).size.width;
                  int crossAxisCount = 1;
                  if (screenWidth > 1200) {
                    crossAxisCount = 4;
                  } else if (screenWidth > 900) {
                    crossAxisCount = 3;
                  } else if (screenWidth > 600) {
                    crossAxisCount = 2;
                  }

                  return RefreshIndicator(
                    onRefresh: () async {
                      await ref.read(clientListProvider.notifier).refresh();
                    },
                    child: GridView.builder(
                      controller: _scrollController,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        childAspectRatio: 1.5,
                        crossAxisSpacing: AppSpacing.md,
                        mainAxisSpacing: AppSpacing.md,
                      ),
                      itemCount: clients.length +
                          (ref.read(clientListProvider.notifier).hasMore
                              ? 1
                              : 0),
                      itemBuilder: (context, index) {
                        if (index == clients.length) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        final clientId = clients[index].id;
                        return ClientCard(
                          client: clients[index],
                          onTap: () {
                            print('Tapped client: ${clients[index].name} (ID: $clientId)');
                            context.push('/clients/$clientId');
                          }
                        );
                      },
                    ),
                  );
                },
                loading: () {
                  return _buildLoadingSkeleton(context);
                },
                error: (error, stack) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.error_outline,
                            size: 48, color: AppColors.error),
                        const SizedBox(height: AppSpacing.md),
                        Text(
                          'Error loading clients',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: isDark
                                ? AppColors.darkText
                                : AppColors.lightText,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Text(
                          error.toString(),
                          style: const TextStyle(color: AppColors.error),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        ElevatedButton(
                          onPressed: () =>
                              ref.read(clientListProvider.notifier).refresh(),
                          child: const Text('Try Again'),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.group_off_outlined,
            size: 64,
            color: isDark
                ? AppColors.darkTextSecondary
                : AppColors.lightTextSecondary,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'No clients found',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: isDark ? AppColors.darkText : AppColors.lightText,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Try adjusting your search or filters',
            style: TextStyle(
              color: isDark
                  ? AppColors.darkTextSecondary
                  : AppColors.lightTextSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingSkeleton(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = 1;
    if (screenWidth > 1200) {
      crossAxisCount = 4;
    } else if (screenWidth > 900) {
      crossAxisCount = 3;
    } else if (screenWidth > 600) {
      crossAxisCount = 2;
    }

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: 1.5,
        crossAxisSpacing: AppSpacing.md,
        mainAxisSpacing: AppSpacing.md,
      ),
      itemCount: 8,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: isDark ? AppColors.darkSurface : AppColors.lightSurface,
          highlightColor: isDark ? AppColors.darkBorder : AppColors.lightBorder,
          child: Container(
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
              borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
            ),
          ),
        );
      },
    );
  }
}
