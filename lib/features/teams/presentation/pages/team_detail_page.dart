import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/gradient_button.dart';
import '../../../../core/widgets/responsive_layout.dart';
import '../../../../generated_code/swagger.swagger.dart';
import '../providers/team_provider.dart';

/// Team member detail page
class TeamDetailPage extends ConsumerWidget {
  final String id;

  const TeamDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Watch the global provider using the 'id'
    final memberValue = ref.watch(memberProvider(id));

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      body: memberValue.when(
        data: (member) => _buildBody(context, ref, member, isDark),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Error: $error'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => context.go('/teams'),
                child: const Text('Back to List'),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildBody(
      BuildContext context, WidgetRef ref, SingleTeamResponseDTO member, bool isDark) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              IconButton(
                onPressed: () => context.go('/teams'),
                icon: const Icon(Iconsax.arrow_left),
                tooltip: 'Back',
              ),
              const SizedBox(width: AppSpacing.md),
              // const Text(
              //   'Member Details',
              //   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              // ),
              const Spacer(),
              _buildActions(context, ref, member),
            ],
          ),
          const SizedBox(height: AppSpacing.xl),

          // Content
          ResponsiveLayout(
            mobile: Column(
              children: [
                _buildAvatarSection(member, isDark),
                const SizedBox(height: AppSpacing.lg),
                _buildInfoSection(member, isDark),
              ],
            ),
            desktop: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 1, child: _buildAvatarSection(member, isDark)),
                const SizedBox(width: AppSpacing.xl),
                Expanded(flex: 2, child: _buildInfoSection(member, isDark)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatarSection(SingleTeamResponseDTO member, bool isDark) {
    return GlassCard(
      isDark: isDark,
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        children: [
          Hero(
            tag: 'member_avatar_${member.data.id}',
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: ClipOval(
                child: member.data.avatar != null && member.data.avatar!.isNotEmpty
                    ? Image.network(
                        member.data.avatar!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            _buildInitials(member),
                      )
                    : _buildInitials(member),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          Text(
            member.data.name,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            member.data.role ?? 'No Role',
            style: TextStyle(
              fontSize: 16,
              color: isDark
                  ? AppColors.darkTextSecondary
                  : AppColors.lightTextSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.lg),
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md, vertical: 6),
            decoration: BoxDecoration(
              color: member.data.isActive ?? false
                  ? AppColors.success.withValues(alpha: 0.1)
                  : AppColors.error.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
              border: Border.all(
                color: member.data.isActive ?? false ? AppColors.success : AppColors.error,
              ),
            ),
            child: Text(
              member.data.isActive ?? false  ? 'Active Member' : 'Inactive Member',
              style: TextStyle(
                color:  member.data.isActive ?? false  ? AppColors.success : AppColors.error,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection(SingleTeamResponseDTO member, bool isDark) {
    final dateFormat = DateFormat('MMM dd, yyyy');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GlassCard(
          isDark: isDark,
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'About',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                member.data.description != null && member.data.description!.isNotEmpty
                    ? member.data.description!
                    : 'No description provided.',
                style: TextStyle(
                  fontSize: 15,
                  height: 1.6,
                  color: isDark ? AppColors.darkText : AppColors.lightText,
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              const Divider(),
              const SizedBox(height: AppSpacing.xl),
              _buildDetailItem(
                label: 'Member ID',
                value: member.data.id,
                isDark: isDark,
              ),
              if(member.data.createdAt != null)
              _buildDetailItem(
                label: 'Joined Date',
                value: dateFormat.format(member.data.createdAt!),
                isDark: isDark,
              ),
              if(member.data.updatedAt != null)
              _buildDetailItem(
                label: 'Last Updated',
                value: dateFormat.format(member.data.updatedAt!),
                isDark: isDark,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDetailItem({
    required String label,
    required String value,
    required bool isDark,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: isDark
                    ? AppColors.darkTextSecondary
                    : AppColors.lightTextSecondary,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActions(BuildContext context, WidgetRef ref, SingleTeamResponseDTO member) {
    return Row(
      children: [
        GradientButton(
          text: 'Edit',
          icon: Iconsax.edit,
          onPressed: () => context.go('/teams/${member.data.id}/edit'),
        ),
        const SizedBox(width: AppSpacing.md),
        OutlinedButton.icon(
          onPressed: () => _showDeleteDialog(context, ref, member),
          icon: Icon(Iconsax.trash, size: 18, color: AppColors.error),
          label: Text('Delete', style: TextStyle(color: AppColors.error)),
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: AppColors.error),
          ),
        ),
      ],
    );
  }

  Widget _buildInitials(SingleTeamResponseDTO member) {
    return Center(
      child: Text(
        member.data.name.substring(0, 1).toUpperCase(),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 80,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  void _showDeleteDialog(
      BuildContext context, WidgetRef ref, SingleTeamResponseDTO member) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Team Member'),
        content: Text(
            'Are you sure you want to delete ${member.data.name}? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              ref.read(teamNotifierProvider.notifier).deleteMember(member.data.id);
              Navigator.pop(context); // Close dialog
              context.go('/teams'); // Redirect list
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
