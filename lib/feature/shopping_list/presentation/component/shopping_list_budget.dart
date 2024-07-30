import 'package:cooki/common/theme/app_colors.dart';
import 'package:cooki/common/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class ShoppingListBudget extends StatelessWidget {
  const ShoppingListBudget({
    super.key,
    required this.budget,
  });

  final num budget;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.backgroundSecondary,
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          const Icon(
            Icons.attach_money,
            size: 24,
          ),
          const SizedBox(width: 12),
          Text(
            'Total',
            style: AppTextStyles.titleSmall,
          ),
          const Spacer(),
          Text(
            'Php ${budget.toStringAsFixed(2)}',
            style: AppTextStyles.bodyLarge,
          ),
        ],
      ),
    );
  }
}
