import 'package:flutter/material.dart';
import '../../../../core/constants/app_spacing.dart';
import 'stat_card.dart';
import '../../../../core/constants/app_strings.dart';

class SummaryGrid extends StatelessWidget {
  const SummaryGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: AppSpacing.md,
      crossAxisSpacing: AppSpacing.md,
      childAspectRatio: 1.0,
      children: const [
        StatCard(
          title: AppStrings.totalSales,
          value: '\$0.00',
          trxCount: '0 ${AppStrings.trx}',
          percentage: '0%',
        ),
        StatCard(
          title: AppStrings.netSales,
          value: '\$0.00',
          trxCount: '0 ${AppStrings.trx}',
          percentage: '0%',
        ),
        StatCard(
          title: AppStrings.refunds,
          value: '\$0.00',
          trxCount: '0 ${AppStrings.trx}',
          percentage: '0%',
        ),
        StatCard(
          title: AppStrings.voidTrx,
          value: '\$0.00',
          trxCount: '0 ${AppStrings.trx}',
          percentage: '0%',
        ),
      ],
    );
  }
}
