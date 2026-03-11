import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/widgets/multi_select_bottom_sheet.dart';
import '../../domain/entities/product_material.dart';

/// Material selector widget with bottom sheet
class MaterialSelector extends ConsumerStatefulWidget {
  final List<ProductMaterial> availableMaterials;
  final List<String> selectedMaterialIds;
  final ValueChanged<List<String>> onSelectionChanged;
  final bool enabled;
  final String? title;

  const MaterialSelector({
    super.key,
    required this.availableMaterials,
    required this.selectedMaterialIds,
    required this.onSelectionChanged,
    this.enabled = true,
    this.title,
  });

  @override
  ConsumerState<MaterialSelector> createState() => _MaterialSelectorState();
}

class _MaterialSelectorState extends ConsumerState<MaterialSelector> {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final selectedMaterials = widget.availableMaterials
        .where((material) => widget.selectedMaterialIds.contains(material.id))
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Row(
          children: [
            Text(
              widget.title ?? 'Materials',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isDark ? AppColors.darkText : AppColors.lightText,
              ),
            ),
            if (widget.enabled) ...[
              const Spacer(),
              TextButton(
                onPressed: _showMaterialBottomSheet,
                child: const Text('Select Materials'),
              ),
            ],
          ],
        ),
        const SizedBox(height: AppSpacing.sm),

        // Selected materials display
        if (selectedMaterials.isEmpty) ...[
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
              widget.enabled ? 'Tap "Select Materials" to add materials' : 'No materials selected',
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
                    '${selectedMaterials.length} material${selectedMaterials.length == 1 ? '' : 's'} selected',
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
                  children: selectedMaterials.map((material) {
                    return Chip(
                      label: Text(material.name,
                      style: isDark
                          ? TextStyle(color: AppColors.darkText)
                          : TextStyle(color: AppColors.lightText)
                      ),
                      backgroundColor: isDark
                          ? AppColors.darkCard
                          : AppColors.lightCard,
                      deleteIcon: widget.enabled ? const Icon(Icons.close, size: 16) : null,
                      onDeleted: widget.enabled
                          ? () {
                              final newSelection = List<String>.from(widget.selectedMaterialIds)
                                ..remove(material.id);
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

  Future<void> _showMaterialBottomSheet() async {
    if (!mounted) return;

    final selectedMaterials = await showMultiSelectBottomSheet<ProductMaterial>(
      context: context,
      title: 'Select Materials',
      items: widget.availableMaterials,
      initialSelection: widget.availableMaterials
          .where((material) => widget.selectedMaterialIds.contains(material.id))
          .toList(),
      searchHint: 'Search materials...',
      itemBuilder: (material) => _buildMaterialItem(material),
    );

    if (selectedMaterials != null) {
      widget.onSelectionChanged(selectedMaterials.map((material) => material.id).toList());
    }
  }

  Widget _buildMaterialItem(ProductMaterial material) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Row(
      children: [
        // Material icon
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.layers,
            size: 14,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        // Material name and description
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                material.name,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              if (material.description != null && material.description!.isNotEmpty) ...[
                const SizedBox(height: 2),
                Text(
                  material.description!,
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark
                        ? AppColors.darkTextSecondary
                        : AppColors.lightTextSecondary,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ],
          ),
        ),
        // Status indicator
        if (!material.isActive)
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm,
              vertical: 2,
            ),
            decoration: BoxDecoration(
              color: AppColors.error.withOpacity(0.1),
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
