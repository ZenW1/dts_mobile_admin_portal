import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_strings.dart';
import '../widgets/analytics_chart.dart';
import '../widgets/month_selector.dart';
import '../widgets/summary_grid.dart';
import 'package:iconsax/iconsax.dart';

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({super.key});

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  String _selectedMonth = 'Mar 2026';
  final List<String> _months = [
    '2025',
    'Dec 2025',
    'Jan 2026',
    'Feb 2026',
    'Mar 2026',
  ];

  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    const Color tealHeaderColor = Color(0xFF00CED1); // Darker cyan/teal

    return Scaffold(
      // backgroundColor: tealHeaderColor,
      body: Stack(
        children: [
          // Pinned Teal Header & Chart Section
          // We don't use IgnorePointer here so the user can interact with the chart
          IgnorePointer(
            child: Container(
              color: tealHeaderColor,
              child: SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Header
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                        vertical: AppSpacing.md,
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(Iconsax.arrow_left_2,
                                color: Colors.white),
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          const Text(
                            AppStrings.analytics,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
            
                    // Month Selector
                    MonthSelector(
                      months: _months,
                      selectedMonth: _selectedMonth,
                      onMonthSelected: (month) {
                        setState(() {
                          _selectedMonth = month;
                        });
                      },
                    ),
            
                    const SizedBox(height: AppSpacing.lg),
            
                    // Chart
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
                      child: AnalyticsChart(),
                    ),
            
                    const SizedBox(height: AppSpacing.xl),
                  ],
                ),
              ),
            ),
          ),

          // Scrollable White Content Area
          SafeArea(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                // Transparent placeholder to allow the teal section to show through
                // IgnorePointer here allows touches to pass to the chart/header behind it
                const SliverToBoxAdapter(
                  child: IgnorePointer(
                    child: SizedBox(
                      height: 370, // Approximate height of the teal section
                    ),
                  ),
                ),

                // White Content Area
                SliverToBoxAdapter(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(AppSpacing.radiusLg),
                        topRight: Radius.circular(AppSpacing.radiusLg),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          offset: Offset(0, -5),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          AppStrings.salesSummary,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF4A4A4A),
                          ),
                        ),
                        const SizedBox(height: AppSpacing.lg),

                        // Grid of 4 cards
                        const SummaryGrid(),

                        const SizedBox(height: AppSpacing.md),

                        // Tip Row
                        Container(
                          padding: const EdgeInsets.all(AppSpacing.md),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(AppSpacing.radiusMd),
                            border: Border.all(color: AppColors.lightBorder),
                          ),
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    AppStrings.tip,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF4A4A4A),
                                    ),
                                  ),
                                  Text(
                                    '0 ${AppStrings.trx}',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.grey.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: const Text(
                                  '0%',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              const SizedBox(width: AppSpacing.md),
                              const Text(
                                '\$0.00',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF4A4A4A),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: AppSpacing.xl),

                        const Text(
                          AppStrings.abaCashback,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF4A4A4A),
                          ),
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        // ABA Cashback placeholder or placeholder logo
                        Container(
                          height: 60,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(AppSpacing.radiusMd),
                            border: Border.all(color: AppColors.lightBorder),
                          ),
                          child: const Center(
                            child: Text(
                              'ABA Cashback Content Placeholder',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ),
                        // Add some bottom padding
                        const SizedBox(height: AppSpacing.xl),
                      ],
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
