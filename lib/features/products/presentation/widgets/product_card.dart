import 'package:dts_admin_portal/generated_code/swagger.swagger.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/widgets/image_placeholder.dart';

/// Product card widget for list/grid view
class ProductCard extends StatefulWidget {
  final ProductResponseDTO product;
  final String? categoryName;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final bool isGridView;

  const ProductCard({
    super.key,
    required this.product,
    this.categoryName,
    this.onTap,
    this.onEdit,
    this.onDelete,
    this.isGridView = false,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (widget.isGridView) {
      return _buildGridCard(isDark);
    }
    return _buildListCard(isDark);
  }

  Widget _buildGridCard(bool isDark) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: AppSpacing.animFast),
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkCard : AppColors.lightCard,
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            border: Border.all(
              color: _isHovered
                  ? (isDark ? AppColors.primaryLight : AppColors.primary)
                  : (isDark ? AppColors.darkBorder : AppColors.lightBorder),
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image
              Expanded(
                flex: 4,
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(AppSpacing.radiusMd),
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      if (widget.product.image != null &&
                          widget.product.image!.isNotEmpty)
                        Image.network(
                          widget.product.image!,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => ImagePlaceholder(
                            text: widget.product.name,
                            borderRadius: 0,
                          ),
                        )
                      else
                        ImagePlaceholder(
                          text: widget.product.name,
                          borderRadius: 0,
                        ),
                      // Status badge
                      Positioned(
                        top: AppSpacing.sm,
                        right: AppSpacing.sm,
                        child: _buildStatusBadge(isDark),
                      ),
                      // Stock badge if low stock
                      if (widget.product.stock <= 5)
                        Positioned(
                          top: AppSpacing.sm,
                          left: AppSpacing.sm,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.sm,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.error.withValues(alpha: 0.9),
                              borderRadius:
                                  BorderRadius.circular(AppSpacing.radiusSm),
                            ),
                            child: Text(
                              widget.product.stock <= 0
                                  ? 'Out of Stock'
                                  : 'Low Stock',
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              // Content
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.product.name,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color:
                              isDark ? AppColors.darkText : AppColors.lightText,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      if (widget.categoryName != null)
                        Text(
                          widget.categoryName!,
                          style: TextStyle(
                            fontSize: 12,
                            color: isDark
                                ? AppColors.darkTextSecondary
                                : AppColors.lightTextSecondary,
                          ),
                          maxLines: 1,
                        ),
                      const Spacer(),
                      Text(
                        '\$${widget.product.price.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isDark
                              ? AppColors.primaryLight
                              : AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListCard(bool isDark) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: AppSpacing.animFast),
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkCard : AppColors.lightCard,
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            border: Border.all(
              color: _isHovered
                  ? (isDark ? AppColors.primaryLight : AppColors.primary)
                  : (isDark ? AppColors.darkBorder : AppColors.lightBorder),
            ),
          ),
          child: Row(
            children: [
              // Image
              ClipRRect(
                borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: widget.product.image != null &&
                          widget.product.image!.isNotEmpty
                      ? Image.network(
                          widget.product.image!,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) =>
                              ImagePlaceholder(text: widget.product.name),
                        )
                      : ImagePlaceholder(text: widget.product.name),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.product.name,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: isDark
                                  ? AppColors.darkText
                                  : AppColors.lightText,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        _buildStatusBadge(isDark),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    if (widget.categoryName != null)
                      Text(
                        widget.categoryName!,
                        style: TextStyle(
                          fontSize: 13,
                          color: isDark
                              ? AppColors.darkTextSecondary
                              : AppColors.lightTextSecondary,
                        ),
                      ),
                    const SizedBox(height: AppSpacing.sm),
                    Row(
                      children: [
                        Text(
                          '\$${widget.product.price.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: isDark
                                ? AppColors.primaryLight
                                : AppColors.primary,
                          ),
                        ),
                        const Spacer(),
                        if (widget.onEdit != null)
                          IconButton(
                            onPressed: widget.onEdit,
                            icon: const Icon(Icons.edit_outlined, size: 20),
                            tooltip: 'Edit',
                            splashRadius: 20,
                          ),
                        if (widget.onDelete != null)
                          IconButton(
                            onPressed: widget.onDelete,
                            icon: Icon(
                              Icons.delete_outline,
                              size: 20,
                              color: AppColors.error,
                            ),
                            tooltip: 'Delete',
                            splashRadius: 20,
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBadge(bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: widget.product.isActive ?? false
            ? AppColors.success.withValues(alpha: 0.1)
            : AppColors.error.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
        border: Border.all(
          color: widget.product.isActive ?? false
              ? AppColors.success.withValues(alpha: 0.5)
              : AppColors.error.withValues(alpha: 0.5),
        ),
      ),
      child: Text(
        widget.product.isActive ?? false ? 'Active' : 'Inactive',
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: widget.product.isActive ?? false
              ? AppColors.success
              : AppColors.error,
        ),
      ),
    );
  }
}
