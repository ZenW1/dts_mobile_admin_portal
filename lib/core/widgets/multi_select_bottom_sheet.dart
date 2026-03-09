import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';

/// Multi-select bottom sheet component
class MultiSelectBottomSheet<T> extends StatefulWidget {
  final String title;
  final List<T> items;
  final List<T> selectedItems;
  final ValueChanged<List<T>> onSelectionChanged;
  final Widget Function(T item) itemBuilder;
  final String? searchHint;
  final bool showSearch;
  final double height;

  const MultiSelectBottomSheet({
    super.key,
    required this.title,
    required this.items,
    required this.selectedItems,
    required this.onSelectionChanged,
    required this.itemBuilder,
    this.searchHint,
    this.showSearch = true,
    this.height = 500,
  });

  @override
  State<MultiSelectBottomSheet<T>> createState() =>
      _MultiSelectBottomSheetState<T>();
}

class _MultiSelectBottomSheetState<T> extends State<MultiSelectBottomSheet<T>> {
  late List<T> _selectedItems;
  late TextEditingController _searchController;
  late List<T> _filteredItems;

  @override
  void initState() {
    super.initState();
    _selectedItems = List.from(widget.selectedItems);
    _searchController = TextEditingController();
    _filteredItems = List.from(widget.items);
    _searchController.addListener(_filterItems);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterItems() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredItems = List.from(widget.items);
      } else {
        _filteredItems = widget.items.where((item) {
          final itemString = item.toString().toLowerCase();
          return itemString.contains(query);
        }).toList();
      }
    });
  }

  void _toggleSelection(T item) {
    setState(() {
      if (_selectedItems.contains(item)) {
        _selectedItems.remove(item);
      } else {
        _selectedItems.add(item);
      }
    });
    widget.onSelectionChanged(_selectedItems);
  }

  void _clearAll() {
    setState(() {
      _selectedItems.clear();
    });
    widget.onSelectionChanged(_selectedItems);
  }

  void _selectAll() {
    setState(() {
      _selectedItems = List.from(_filteredItems);
    });
    widget.onSelectionChanged(_selectedItems);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      height: widget.height,
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : AppColors.lightCard,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(AppSpacing.radiusLg),
        ),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    widget.title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                if (_selectedItems.isNotEmpty) ...[
                  TextButton(
                    onPressed: _clearAll,
                    child: const Text('Clear All'),
                  ),
                  const SizedBox(width: AppSpacing.xs),
                ],
                TextButton(
                  onPressed: _selectedItems.length == _filteredItems.length
                      ? _clearAll
                      : _selectAll,
                  child: Text(_selectedItems.length == _filteredItems.length
                      ? 'Deselect All'
                      : 'Select All'),
                ),
              ],
            ),
          ),

          // Search
          if (widget.showSearch) ...[
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: widget.searchHint ?? 'Search...',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: isDark ? AppColors.darkSurface : AppColors.lightSurface,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                    borderSide: BorderSide(
                      color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                    borderSide: BorderSide(
                      color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                    ),
                  ),
                ),
              ),
            ),
          ],

          // Selected items indicator
          if (_selectedItems.isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: AppSpacing.xs,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                    ),
                    child: Text(
                      '${_selectedItems.length} selected',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.md),
          ],

          // Items list
          Expanded(
            child: _filteredItems.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 48,
                          color: isDark
                              ? AppColors.darkTextSecondary
                              : AppColors.lightTextSecondary,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Text(
                          'No items found',
                          style: TextStyle(
                            color: isDark
                                ? AppColors.darkTextSecondary
                                : AppColors.lightTextSecondary,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                    itemCount: _filteredItems.length,
                    itemBuilder: (context, index) {
                      final item = _filteredItems[index];
                      final isSelected = _selectedItems.contains(item);
                      
                      return Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                            onTap: () => _toggleSelection(item),
                            child: Container(
                              padding: const EdgeInsets.all(AppSpacing.md),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                                border: Border.all(
                                  color: isSelected
                                      ? AppColors.primary
                                      : (isDark
                                          ? AppColors.darkBorder
                                          : AppColors.lightBorder),
                                ),
                                color: isSelected
                                    ? AppColors.primary.withOpacity(0.1)
                                    : Colors.transparent,
                              ),
                              child: Row(
                                children: [
                                  // Checkbox
                                  Checkbox(
                                    value: isSelected,
                                    onChanged: (_) => _toggleSelection(item),
                                    activeColor: AppColors.primary,
                                  ),
                                  // Item content
                                  Expanded(child: widget.itemBuilder(item)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),

          // Actions
          Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Row(
              children: [
                OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context, _selectedItems),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                    ),
                    child: Text(
                      'Confirm (${_selectedItems.length})',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Convenience method to show multi-select bottom sheet
Future<List<T>?> showMultiSelectBottomSheet<T>({
  required BuildContext context,
  required String title,
  required List<T> items,
  required List<T> initialSelection,
  required Widget Function(T item) itemBuilder,
  String? searchHint,
  bool showSearch = true,
  double height = 500,
}) {
  return showModalBottomSheet<List<T>>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => MultiSelectBottomSheet<T>(
      title: title,
      items: items,
      selectedItems: initialSelection,
      onSelectionChanged: (selection) {
        // Optional: Handle real-time selection changes
      },
      itemBuilder: itemBuilder,
      searchHint: searchHint,
      showSearch: showSearch,
      height: height,
    ),
  );
}
