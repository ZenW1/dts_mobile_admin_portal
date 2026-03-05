import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/widgets/responsive_layout.dart';
import '../widgets/sidebar_nav.dart';

/// Admin layout with sidebar navigation
class AdminLayout extends StatefulWidget {
  final Widget child;

  const AdminLayout({
    super.key,
    required this.child,
  });

  @override
  State<AdminLayout> createState() => _AdminLayoutState();
}

class _AdminLayoutState extends State<AdminLayout> {
  bool _isSidebarCollapsed = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isMobile = ResponsiveLayout.isMobile(context);

    if (isMobile) {
      return Scaffold(
        drawer: Drawer(
          child: SidebarNav(
            isCollapsed: false,
            onToggle: () {},
          ),
        ),
        appBar: AppBar(
          backgroundColor:
              isDark ? AppColors.darkSurface : AppColors.lightSurface,
          elevation: 0,
          leading: Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
        ),
        body: widget.child,
      );
    }

    return Scaffold(
      body: Row(
        children: [
          // Sidebar
          SidebarNav(
            isCollapsed: _isSidebarCollapsed,
            onToggle: () {
              setState(() {
                _isSidebarCollapsed = !_isSidebarCollapsed;
              });
            },
          ),

          // Main content
          Expanded(
            child: Container(
              color:
                  isDark ? AppColors.darkBackground : AppColors.lightBackground,
              child: widget.child,
            ),
          ),
        ],
      ),
    );
  }
}
