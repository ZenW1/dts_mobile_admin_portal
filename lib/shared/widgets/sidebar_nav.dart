import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/theme/theme_provider.dart';

/// Navigation item model
class NavItem {
  final String title;
  final IconData icon;
  final IconData activeIcon;
  final String path;

  const NavItem({
    required this.title,
    required this.icon,
    required this.activeIcon,
    required this.path,
  });
}

/// List of navigation items
const List<NavItem> navItems = [
  NavItem(
    title: 'Dashboard',
    icon: Iconsax.home,
    activeIcon: Iconsax.home_15,
    path: '/',
  ),
  NavItem(
    title: 'Products',
    icon: Iconsax.box,
    activeIcon: Iconsax.box5,
    path: '/products',
  ),
  NavItem(
    title: 'Product Categories',
    icon: Iconsax.category,
    activeIcon: Iconsax.category5,
    path: '/product-categories',
  ),
  NavItem(
    title: 'Portfolio',
    icon: Iconsax.gallery,
    activeIcon: Iconsax.gallery5,
    path: '/portfolio',
  ),
  NavItem(
    title: 'Portfolio Categories',
    icon: Iconsax.folder,
    activeIcon: Iconsax.folder5,
    path: '/portfolio-categories',
  ),
  NavItem(
    title: 'Clients',
    icon: Iconsax.profile_2user,
    activeIcon: Iconsax.profile_2user5,
    path: '/clients',
  ),
  NavItem(
    title: 'Jobs',
    icon: Iconsax.briefcase,
    activeIcon: Iconsax.briefcase5,
    path: '/jobs',
  ),
  NavItem(
    title: 'Customer Feedback',
    icon: Iconsax.message_text,
    activeIcon: Iconsax.message_text_1,
    path: '/feedbacks',
  ),
];

/// Collapsible sidebar navigation
class SidebarNav extends ConsumerStatefulWidget {
  final bool isCollapsed;
  final VoidCallback onToggle;

  const SidebarNav({
    super.key,
    required this.isCollapsed,
    required this.onToggle,
  });

  @override
  ConsumerState<SidebarNav> createState() => _SidebarNavState();
}

class _SidebarNavState extends ConsumerState<SidebarNav> {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final currentPath = GoRouterState.of(context).uri.path;

    return AnimatedContainer(
      duration: const Duration(milliseconds: AppSpacing.animNormal),
      width: widget.isCollapsed
          ? AppSpacing.sidebarCollapsedWidth
          : AppSpacing.sidebarWidth,
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
        border: Border(
          right: BorderSide(
            color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
          ),
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            // Logo and toggle
            _buildHeader(isDark),

            const Divider(height: 1),

            // Nav items
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                children: navItems.map((item) {
                  final isActive = currentPath == item.path;
                  return _buildNavItem(item, isActive, isDark);
                }).toList(),
              ),
            ),

            const Divider(height: 1),

            // Theme toggle at bottom
            _buildThemeToggle(isDark),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(bool isDark) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: Row(
        children: [
          // Logo
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
            ),
            child: const Center(
              child: Text(
                'D',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          if (!widget.isCollapsed) ...[
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Text(
                'DTS Admin',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isDark ? AppColors.darkText : AppColors.lightText,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
          const Spacer(),
          IconButton(
            onPressed: widget.onToggle,
            icon: Icon(
              widget.isCollapsed ? Iconsax.arrow_right_3 : Iconsax.arrow_left_2,
              size: 20,
            ),
            tooltip: widget.isCollapsed ? 'Expand' : 'Collapse',
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(NavItem item, bool isActive, bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
        child: InkWell(
          onTap: () => context.go(item.path),
          borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: AppSpacing.animFast),
            padding: EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: widget.isCollapsed ? AppSpacing.md : AppSpacing.sm + 4,
            ),
            decoration: BoxDecoration(
              color: isActive
                  ? (isDark
                      ? AppColors.primaryLight.withValues(alpha: 0.15)
                      : AppColors.primary.withValues(alpha: 0.1))
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
            ),
            child: Row(
              mainAxisAlignment: widget.isCollapsed
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.start,
              children: [
                Icon(
                  isActive ? item.activeIcon : item.icon,
                  size: 22,
                  color: isActive
                      ? (isDark ? AppColors.primaryLight : AppColors.primary)
                      : (isDark
                          ? AppColors.darkTextSecondary
                          : AppColors.lightTextSecondary),
                ),
                if (!widget.isCollapsed) ...[
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Text(
                      item.title,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight:
                            isActive ? FontWeight.w600 : FontWeight.w500,
                        color: isActive
                            ? (isDark
                                ? AppColors.primaryLight
                                : AppColors.primary)
                            : (isDark
                                ? AppColors.darkText
                                : AppColors.lightText),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildThemeToggle(bool isDark) {
    final themeNotifier = ref.read(themeProvider.notifier);

    return Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: widget.isCollapsed
          ? IconButton(
              onPressed: () => themeNotifier.toggleTheme(),
              icon: Icon(
                isDark ? Iconsax.sun_1 : Iconsax.moon,
                size: 22,
              ),
              tooltip: isDark ? 'Light Mode' : 'Dark Mode',
            )
          : Row(
              children: [
                Icon(
                  isDark ? Iconsax.moon5 : Iconsax.sun_15,
                  size: 20,
                  color: isDark
                      ? AppColors.darkTextSecondary
                      : AppColors.lightTextSecondary,
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Text(
                    isDark ? 'Dark Mode' : 'Light Mode',
                    style: TextStyle(
                      fontSize: 13,
                      color: isDark
                          ? AppColors.darkTextSecondary
                          : AppColors.lightTextSecondary,
                    ),
                  ),
                ),
                Switch(
                  value: isDark,
                  onChanged: (_) => themeNotifier.toggleTheme(),
                  activeColor: AppColors.primaryLight,
                ),
              ],
            ),
    );
  }
}
