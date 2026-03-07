import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/widgets/image_placeholder.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dts_admin_portal/generated_code/swagger.swagger.dart';

/// Portfolio grid item widget
class PortfolioGridItem extends StatefulWidget {
  final PortfolioResponseDTO portfolio;
  final String? categoryName;
  final VoidCallback? onTap;

  const PortfolioGridItem({
    super.key,
    required this.portfolio,
    this.categoryName,
    this.onTap,
  });

  @override
  State<PortfolioGridItem> createState() => _PortfolioGridItemState();
}

class _PortfolioGridItemState extends State<PortfolioGridItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: AppSpacing.animFast),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.2),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ]
                : [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Image
                if (widget.portfolio.image.isNotEmpty)
                  CachedNetworkImage(
                    imageUrl: widget.portfolio.projectUrl ?? '',
                    fit: BoxFit.cover,
                    placeholder: (context, url) => ImagePlaceholder(
                      text: widget.portfolio.title,
                      borderRadius: 0,
                    ),
                    errorWidget: (context, url, error) => ImagePlaceholder(
                      text: widget.portfolio.title,
                      borderRadius: 0,
                    ),
                  )
                else
                  ImagePlaceholder(
                    text: widget.portfolio.title,
                    borderRadius: 0,
                  ),

                // Gradient overlay
                AnimatedContainer(
                  duration: const Duration(milliseconds: AppSpacing.animNormal),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withValues(alpha: _isHovered ? 0.8 : 0.6),
                      ],
                      stops: const [0.3, 1.0],
                    ),
                  ),
                ),

                // Featured badge
                if (widget.portfolio.isActive == true)
                  Positioned(
                    top: AppSpacing.sm,
                    right: AppSpacing.sm,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.sm,
                        vertical: AppSpacing.xs,
                      ),
                      decoration: BoxDecoration(
                        gradient: AppColors.accentGradient,
                        borderRadius:
                            BorderRadius.circular(AppSpacing.radiusSm),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.star, size: 12, color: Colors.white),
                          SizedBox(width: 4),
                          Text(
                            'Featured',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                // Content
                Positioned(
                  left: AppSpacing.md,
                  right: AppSpacing.md,
                  bottom: AppSpacing.md,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (widget.categoryName != null)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.sm,
                            vertical: AppSpacing.xs - 2,
                          ),
                          margin: const EdgeInsets.only(bottom: AppSpacing.xs),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius:
                                BorderRadius.circular(AppSpacing.radiusSm),
                          ),
                          child: Text(
                            widget.categoryName!,
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      Text(
                        widget.portfolio.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (widget.portfolio.$client != null) ...[
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          widget.portfolio.$client!,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white.withValues(alpha: 0.8),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),

                // Hover arrow
                AnimatedPositioned(
                  duration: const Duration(milliseconds: AppSpacing.animFast),
                  right: _isHovered ? AppSpacing.md : -30,
                  top: AppSpacing.md,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: AppSpacing.animFast),
                    opacity: _isHovered ? 1.0 : 0.0,
                    child: Container(
                      padding: const EdgeInsets.all(AppSpacing.sm),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(AppSpacing.radiusFull),
                      ),
                      child: const Icon(
                        Icons.arrow_forward,
                        size: 16,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
