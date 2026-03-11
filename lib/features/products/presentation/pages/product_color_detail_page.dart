import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/widgets/gradient_button.dart';
import '../../../../core/services/toast_service.dart';

import '../providers/product_color_provider.dart';

/// Product Color detail page
class ProductColorDetailPage extends ConsumerWidget {
  final String id;

  const ProductColorDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorAsync = ref.watch(productColorDetailProvider(id));

    return Scaffold(
      backgroundColor:
          isDark ? AppColors.darkBackground : AppColors.lightBackground,
      body: colorAsync.when(
        data: (color) {
          if (color == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Iconsax.warning_2, size: 64, color: AppColors.error),
                  const SizedBox(height: AppSpacing.md),
                  const Text('Color not found'),
                  const SizedBox(height: AppSpacing.md),
                  GradientButton(
                    text: 'Back to Colors',
                    onPressed: () => context.go('/product-colors'),
                  ),
                ],
              ),
            );
          }

          Color swatchColor = AppColors.primary;
          if (color.hexCode != null && color.hexCode!.isNotEmpty) {
            try {
              final hex = color.hexCode!.replaceAll('#', '').padLeft(6, '0');
              swatchColor = Color(int.parse('FF$hex', radix: 16));
            } catch (_) {}
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back + Actions
                Row(
                  children: [
                    IconButton(
                      onPressed: () => context.go('/product-colors'),
                      icon: const Icon(Iconsax.arrow_left),
                    ),
                    const Spacer(),
                    OutlinedButton.icon(
                      onPressed: () => context.go('/product-colors/$id/edit'),
                      icon: const Icon(Iconsax.edit, size: 18),
                      label: const Text('Edit'),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    OutlinedButton.icon(
                      onPressed: () =>
                          _showDeleteDialog(context, ref, color.name),
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

                // Large color swatch hero
                Center(
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      color: swatchColor,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: swatchColor.withValues(alpha: 0.5),
                          blurRadius: 40,
                          spreadRadius: 10,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),

                // Name
                Center(
                  child: Text(
                    color.name,
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),

                // Hex chip
                if (color.hexCode != null)
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Clipboard.setData(ClipboardData(text: color.hexCode!));
                        ToastService.info(
                          message: 'Hex code copied to clipboard',
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.md,
                          vertical: AppSpacing.xs,
                        ),
                        decoration: BoxDecoration(
                          color: swatchColor.withValues(alpha: 0.15),
                          borderRadius:
                              BorderRadius.circular(AppSpacing.radiusFull),
                          border: Border.all(
                              color: swatchColor.withValues(alpha: 0.4)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Iconsax.copy, size: 14, color: swatchColor),
                            const SizedBox(width: AppSpacing.xs),
                            Text(
                              color.hexCode!.toUpperCase(),
                              style: TextStyle(
                                fontFamily: 'monospace',
                                fontWeight: FontWeight.bold,
                                color: swatchColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                const SizedBox(height: AppSpacing.xl),

                // Status badge
                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md, vertical: AppSpacing.xs),
                    decoration: BoxDecoration(
                      color: color.isActive
                          ? AppColors.success.withValues(alpha: 0.1)
                          : AppColors.error.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                    ),
                    child: Text(
                      color.isActive ? 'Active' : 'Inactive',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: color.isActive
                            ? AppColors.success
                            : AppColors.error,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error loading color: $error')),
      ),
    );
  }

  void _showDeleteDialog(
      BuildContext context, WidgetRef ref, String colorName) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete Color'),
        content: Text(
            'Are you sure you want to delete "$colorName"? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              final success = await ref
                  .read(productColorsNotifierProvider.notifier)
                  .deleteColor(id);
              if (context.mounted) {
                Navigator.pop(dialogContext);
                if (success) {
                  context.go('/product-colors');
                } else {
                  ToastService.error(message: 'Failed to delete color');
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
