import 'package:cooki/common/theme/app_colors.dart';
import 'package:cooki/common/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class ShoppingListSummary extends StatelessWidget {
  const ShoppingListSummary({
    super.key,
    required this.totalPrice,
    required this.budget,
  });

  final num totalPrice;
  final num budget;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _SummaryRow(
          label: 'Total',
          detail: totalPrice,
          backgroundColor: AppColors.accent,
          color: AppColors.fontSecondary,
          icon: Icons.attach_money,
        ),
        _SummaryRow(
          label: 'Budget',
          detail: budget,
          backgroundColor: AppColors.backgroundSecondary,
          color: AppColors.fontPrimary,
          icon: Icons.savings_rounded,
        ),
      ],
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.backgroundColor,
    required this.color,
    required this.label,
    required this.detail,
    required this.icon,
  });

  final String label;
  final num detail;
  final Color backgroundColor;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      width: double.infinity,
      color: backgroundColor,
      child: Row(
        children: [
          Icon(
            icon,
            size: 24,
            color: color,
          ),
          const SizedBox(width: 12),
          Text(
            label,
            style: AppTextStyles.titleSmall.copyWith(
              color: color,
            ),
          ),
          const Spacer(),
          Text(
            'Php ${detail.toStringAsFixed(2)}',
            style: AppTextStyles.titleSmall.copyWith(
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
