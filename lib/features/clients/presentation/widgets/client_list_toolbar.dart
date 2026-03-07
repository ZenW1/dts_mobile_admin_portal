import 'dart:async';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../domain/entities/client.dart';

class ClientListToolbar extends StatefulWidget {
  final String initialSearchQuery;
  final ClientStatus? initialStatus;
  final Function(String) onSearchChanged;
  final Function(ClientStatus?) onStatusChanged;
  final VoidCallback onAddClient;

  const ClientListToolbar({
    super.key,
    required this.initialSearchQuery,
    required this.initialStatus,
    required this.onSearchChanged,
    required this.onStatusChanged,
    required this.onAddClient,
  });

  @override
  State<ClientListToolbar> createState() => _ClientListToolbarState();
}

class _ClientListToolbarState extends State<ClientListToolbar> {
  late TextEditingController _searchController;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: widget.initialSearchQuery);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      widget.onSearchChanged(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Wrap(
      spacing: AppSpacing.md,
      runSpacing: AppSpacing.md,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        // Search Bar
        SizedBox(
          width: 300,
          child: TextField(
            controller: _searchController,
            onChanged: _onSearchChanged,
            decoration: InputDecoration(
              hintText: 'Search clients...',
              prefixIcon: const Icon(Iconsax.search_normal),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                borderSide: BorderSide(
                  color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                borderSide: BorderSide(
                  color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                ),
              ),
              filled: true,
              fillColor:
                  isDark ? AppColors.darkSurface : AppColors.lightSurface,
            ),
          ),
        ),

        // Status Filter
        Container(
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
            border: Border.all(
              color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
            ),
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<ClientStatus?>(
              value: widget.initialStatus,
              hint: const Text('All Statuses'),
              icon: const Icon(Iconsax.arrow_down_1, size: 16),
              dropdownColor:
                  isDark ? AppColors.darkSurface : AppColors.lightSurface,
              onChanged: widget.onStatusChanged,
              items: const [
                DropdownMenuItem(
                  value: null,
                  child: Text('All Statuses'),
                ),
                DropdownMenuItem(
                  value: ClientStatus.active,
                  child: Text('Active'),
                ),
                DropdownMenuItem(
                  value: ClientStatus.inactive,
                  child: Text('Inactive'),
                ),
                DropdownMenuItem(
                  value: ClientStatus.prospect,
                  child: Text('Prospect'),
                ),
              ],
            ),
          ),
        ),

        // Add Button
        ElevatedButton.icon(
          onPressed: widget.onAddClient,
          icon: const Icon(Iconsax.add),
          label: const Text('Add Client'),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.md,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            ),
          ),
        ),
      ],
    );
  }
}
