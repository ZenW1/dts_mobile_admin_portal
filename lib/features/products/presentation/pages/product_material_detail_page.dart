import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/widgets/gradient_button.dart';
import '../../../../core/services/toast_service.dart';

import '../providers/product_material_provider.dart';

/// Product Material detail page
class ProductMaterialDetailPage extends ConsumerWidget {
  final String id;

  const ProductMaterialDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final materialAsync = ref.watch(productMaterialDetailProvider(id));

    return Scaffold(
      backgroundColor:
          isDark ? AppColors.darkBackground : AppColors.lightBackground,
      body: materialAsync.when(
        data: (material) {
          if (material == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Iconsax.warning_2, size: 64, color: AppColors.error),
                  const SizedBox(height: AppSpacing.md),
                  const Text('Material not found'),
                  const SizedBox(height: AppSpacing.md),
                  GradientButton(
                    text: 'Back to Materials',
                    onPressed: () => context.go('/product-materials'),
                  ),
                ],
              ),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  children: [
                    IconButton(
                      onPressed: () => context.go('/product-materials'),
                      icon: const Icon(Iconsax.arrow_left),
                    ),
                    const Spacer(),
                    OutlinedButton.icon(
                      onPressed: () =>
                          context.go('/product-materials/$id/edit'),
                      icon: const Icon(Iconsax.edit, size: 18),
                      label: const Text('Edit'),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    OutlinedButton.icon(
                      onPressed: () =>
                          _showDeleteDialog(context, ref, material.name),
                      icon:
                          Icon(Iconsax.trash, size: 18, color: AppColors.error),
                      label: Text('Delete',
                          style: TextStyle(color: AppColors.error)),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: AppColors.error),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xl),

                // Icon + Name
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                        gradient: AppColors.primaryGradient,
                        borderRadius:
                            BorderRadius.circular(AppSpacing.radiusLg),
                      ),
                      child: const Icon(
                        Iconsax.category,
                        color: Colors.white,
                        size: 36,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.lg),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            material.name,
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                          const SizedBox(height: AppSpacing.xs),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: AppSpacing.md,
                                vertical: AppSpacing.xs),
                            decoration: BoxDecoration(
                              color: material.isActive
                                  ? AppColors.success.withValues(alpha: 0.1)
                                  : AppColors.error.withValues(alpha: 0.1),
                              borderRadius:
                                  BorderRadius.circular(AppSpacing.radiusSm),
                            ),
                            child: Text(
                              material.isActive ? 'Active' : 'Inactive',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                                color: material.isActive
                                    ? AppColors.success
                                    : AppColors.error,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                if (material.description != null &&
                    material.description!.isNotEmpty) ...[
                  const SizedBox(height: AppSpacing.xl),
                  Text('Description',
                      style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    material.description!,
                    style: TextStyle(
                      height: 1.6,
                      color: isDark ? AppColors.darkText : AppColors.lightText,
                    ),
                  ),
                ],

                const SizedBox(height: AppSpacing.xl),

                // Metadata
                Container(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.darkCard : AppColors.lightCard,
                    borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                    border: Border.all(
                      color:
                          isDark ? AppColors.darkBorder : AppColors.lightBorder,
                    ),
                  ),
                  child: Column(
                    children: [
                      _metaRow(context, 'Material ID', material.id, isDark),
                      if (material.createdAt != null) ...[
                        const Divider(),
                        _metaRow(
                          context,
                          'Created',
                          material.createdAt!
                              .toLocal()
                              .toString()
                              .split('.')
                              .first,
                          isDark,
                        ),
                      ],
                      if (material.updatedAt != null) ...[
                        const Divider(),
                        _metaRow(
                          context,
                          'Last Updated',
                          material.updatedAt!
                              .toLocal()
                              .toString()
                              .split('.')
                              .first,
                          isDark,
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error loading material: $e')),
      ),
    );
  }

  Widget _metaRow(
      BuildContext context, String label, String value, bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              color: isDark
                  ? AppColors.darkTextSecondary
                  : AppColors.lightTextSecondary,
            ),
          ),
          const Spacer(),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: isDark ? AppColors.darkText : AppColors.lightText,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(
      BuildContext context, WidgetRef ref, String materialName) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete Material'),
        content: Text(
            'Are you sure you want to delete "$materialName"? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              final success = await ref
                  .read(productMaterialsNotifierProvider.notifier)
                  .deleteMaterial(id);
              if (context.mounted) {
                Navigator.pop(dialogContext);
                if (success) {
                  context.go('/product-materials');
                } else {
                  ToastService.error(message: 'Failed to delete material');
                }
              }
            },
            child: Text('Delete', style: TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    );
  }
}
