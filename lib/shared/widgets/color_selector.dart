import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/widgets/multi_select_bottom_sheet.dart';
import '../../features/products/domain/entities/product_color.dart';

/// Color selector widget with bottom sheet
class ColorSelector extends ConsumerStatefulWidget {
  final List<ProductColor> availableColors;
  final List<String> selectedColorIds;
  final ValueChanged<List<String>> onSelectionChanged;
  final bool enabled;
  final String? title;

  const ColorSelector({
    super.key,
    required this.availableColors,
    required this.selectedColorIds,
    required this.onSelectionChanged,
    this.enabled = true,
    this.title,
  });

  @override
  ConsumerState<ColorSelector> createState() => _ColorSelectorState();
}

class _ColorSelectorState extends ConsumerState<ColorSelector> {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final selectedColors = widget.availableColors
        .where((color) => widget.selectedColorIds.contains(color.id))
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Row(
          children: [
            Text(
              widget.title ?? 'Colors',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isDark ? AppColors.darkText : AppColors.lightText,
              ),
            ),
            if (widget.enabled) ...[
              const Spacer(),
              TextButton(
                onPressed: _showColorBottomSheet,
                child: const Text('Select Colors'),
              ),
            ],
          ],
        ),
        const SizedBox(height: AppSpacing.sm),

        // Selected colors display
        if (selectedColors.isEmpty) ...[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
              borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
              border: Border.all(
                color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
              ),
            ),
            child: Text(
              widget.enabled ? 'Tap "Select Colors" to add colors' : 'No colors selected',
              style: TextStyle(
                color: isDark
                    ? AppColors.darkTextSecondary
                    : AppColors.lightTextSecondary,
                fontSize: 14,
              ),
            ),
          ),
        ] else ...[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
              borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
              border: Border.all(
                color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.enabled)
                  Text(
                    '${selectedColors.length} color${selectedColors.length == 1 ? '' : 's'} selected',
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark
                          ? AppColors.darkTextSecondary
                          : AppColors.lightTextSecondary,
                    ),
                  ),
                const SizedBox(height: AppSpacing.sm),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: selectedColors.map((color) {
                    return Chip(
                      label: Text(color.name),
                      avatar: color.hexCode != null && color.hexCode!.startsWith('#')
                          ? Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: Color(int.parse(
                              color.hexCode!.replaceAll('#', '0xFF'))),
                          shape: BoxShape.circle,
                        ),
                      )
                          : null,
                      backgroundColor: isDark
                          ? AppColors.darkCard
                          : AppColors.lightCard,
                      deleteIcon: widget.enabled ? const Icon(Icons.close, size: 16) : null,
                      onDeleted: widget.enabled
                          ? () {
                        final newSelection = List<String>.from(widget.selectedColorIds)
                          ..remove(color.id);
                        widget.onSelectionChanged(newSelection);
                      }
                          : null,
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Future<void> _showColorBottomSheet() async {
    final context = this.context;
    if (!context.mounted) return;

    final selectedColors = await showMultiSelectBottomSheet<ProductColor>(
      context: context,
      title: 'Select Colors',
      items: widget.availableColors,
      initialSelection: widget.availableColors
          .where((color) => widget.selectedColorIds.contains(color.id))
          .toList(),
      searchHint: 'Search colors...',
      itemBuilder: (color) => _buildColorItem(color),
    );

    if (selectedColors != null) {
      widget.onSelectionChanged(selectedColors.map((color) => color.id).toList());
    }
  }

  Widget _buildColorItem(ProductColor color) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      children: [
        // Color preview
        if (color.hexCode != null && color.hexCode!.startsWith('#')) ...[
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: Color(int.parse(color.hexCode!.replaceAll('#', '0xFF'))),
              shape: BoxShape.circle,
              border: Border.all(
                color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
        ],
        // Color name
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                color.name,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              if (color.hexCode != null) ...[
                const SizedBox(height: 2),
                Text(
                  color.hexCode!,
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark
                        ? AppColors.darkTextSecondary
                        : AppColors.lightTextSecondary,
                  ),
                ),
              ],
            ],
          ),
        ),
        // Status indicator
        if (!color.isActive)
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm,
              vertical: 2,
            ),
            decoration: BoxDecoration(
              color: AppColors.error.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
            ),
            child: Text(
              'Inactive',
              style: TextStyle(
                fontSize: 10,
                color: AppColors.error,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
      ],
    );
  }
}
