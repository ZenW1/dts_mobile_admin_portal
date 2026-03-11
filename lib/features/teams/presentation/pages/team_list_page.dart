import 'package:dts_admin_portal/generated_code/swagger.swagger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/widgets/gradient_button.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/shimmer_loading.dart';
import '../../../../core/widgets/responsive_layout.dart';
import '../providers/team_provider.dart';
import '../widgets/team_member_card.dart';
import '../../domain/entities/team_member.dart';

/// Team list page
class TeamListPage extends ConsumerStatefulWidget {
  const TeamListPage({super.key});

  @override
  ConsumerState<TeamListPage> createState() => _TeamListPageState();
}

class _TeamListPageState extends ConsumerState<TeamListPage> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final filteredTeams = ref.watch(filteredTeamsProvider);
    final filter = ref.watch(teamFilterProvider);

    return Scaffold(
      backgroundColor:
          isDark ? AppColors.darkBackground : AppColors.lightBackground,
      body: CustomScrollView(
        slivers: [
          // Header
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and actions
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Team',
                              style: Theme.of(context).textTheme.displaySmall,
                            ),
                            const SizedBox(height: AppSpacing.xs),
                            Text(
                              'Manage your stellar team members',
                              style: TextStyle(
                                color: isDark
                                    ? AppColors.darkTextSecondary
                                    : AppColors.lightTextSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      GradientButton(
                        text: 'Add Member',
                        icon: Iconsax.add,
                        onPressed: () => context.go('/teams/new'),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.lg),

                  // Search and filters
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          controller: _searchController,
                          hint: 'Search members...',
                          prefixIcon:
                              const Icon(Iconsax.search_normal, size: 20),
                          onChanged: (value) {
                            ref.read(teamFilterProvider.notifier).state =
                                filter.copyWith(searchQuery: value);
                          },
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      // Active/Inactive filter chips
                      _buildFilterChip(
                        label: 'Active',
                        isSelected: filter.isActive == true,
                        onTap: () {
                          ref.read(teamFilterProvider.notifier).state =
                              filter.copyWith(
                            isActive: filter.isActive == true ? null : true,
                          );
                        },
                        isDark: isDark,
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      _buildFilterChip(
                        label: 'Inactive',
                        isSelected: filter.isActive == false,
                        onTap: () {
                          ref.read(teamFilterProvider.notifier).state =
                              filter.copyWith(
                            isActive: filter.isActive == false ? null : false,
                          );
                        },
                        isDark: isDark,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Teams grid
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              0,
              AppSpacing.lg,
              AppSpacing.lg,
            ),
            sliver: filteredTeams.when(
              data: (members) {
                if (members.isEmpty) {
                  return SliverToBoxAdapter(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(AppSpacing.xxl),
                        child: Column(
                          children: [
                            Icon(
                              Iconsax.people,
                              size: 64,
                              color: isDark
                                  ? AppColors.darkTextSecondary
                                  : AppColors.lightTextSecondary,
                            ),
                            const SizedBox(height: AppSpacing.md),
                            Text(
                              'No team members found',
                              style: TextStyle(
                                fontSize: 16,
                                color: isDark
                                    ? AppColors.darkTextSecondary
                                    : AppColors.lightTextSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }

                return SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: ResponsiveLayout.gridColumns(context),
                    mainAxisSpacing: AppSpacing.md,
                    crossAxisSpacing: AppSpacing.md,
                    childAspectRatio: 0.7,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final member = members[index];
                      return TeamMemberCard(
                        member: member,
                        onTap: () => context.go('/teams/${member.id}'),
                        onEdit: () => context.go('/teams/${member.id}/edit'),
                        onDelete: () => _showDeleteDialog(context, member),
                      );
                    },
                    childCount: members.length,
                  ),
                );
              },
              loading: () => SliverToBoxAdapter(
                child: ShimmerGrid(
                  itemCount: 8,
                  crossAxisCount: ResponsiveLayout.gridColumns(context),
                ),
              ),
              error: (error, _) => SliverToBoxAdapter(
                child: Center(
                  child: Text('Error: $error'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
    required bool isDark,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: AppSpacing.animFast),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          decoration: BoxDecoration(
            color: isSelected
                ? (isDark ? AppColors.primaryLight : AppColors.primary)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
            border: Border.all(
              color: isSelected
                  ? (isDark ? AppColors.primaryLight : AppColors.primary)
                  : (isDark ? AppColors.darkBorder : AppColors.lightBorder),
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              color: isSelected
                  ? Colors.white
                  : (isDark ? AppColors.darkText : AppColors.lightText),
            ),
          ),
        ),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, TeamResponseDTO member) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Team Member'),
        content: Text(
            'Are you sure you want to remove ${member.name} from the team?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              ref.read(teamNotifierProvider.notifier).deleteMember(member.id);
              Navigator.pop(context);
            },
            child: Text(
              'Delete',
              style: TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }
}
