import 'package:flutter/material.dart';
import '../../../../core/constants/app_spacing.dart';

class MonthSelector extends StatelessWidget {
  final List<String> months;
  final String selectedMonth;
  final Function(String) onMonthSelected;

  const MonthSelector({
    super.key,
    required this.months,
    required this.selectedMonth,
    required this.onMonthSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
        itemCount: months.length,
        itemBuilder: (context, index) {
          final month = months[index];
          final isSelected = month == selectedMonth;

          return GestureDetector(
            onTap: () => onMonthSelected(month),
            child: Container(
              margin: const EdgeInsets.only(right: AppSpacing.lg),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    month,
                    style: TextStyle(
                      color: isSelected
                          ? Colors.white
                          : Colors.white.withValues(alpha: 0.7),
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  if (isSelected)
                    Container(
                      height: 2,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(1),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
