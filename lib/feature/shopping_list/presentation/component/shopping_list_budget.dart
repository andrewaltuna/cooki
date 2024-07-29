import 'package:cooki/common/theme/app_colors.dart';
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
      padding: const EdgeInsets.all(
        12,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Row(children: [
            Icon(
              Icons.monetization_on,
              size: 24,
            ),
            SizedBox(
              width: 12,
            ),
            Text(
              "Total",
            ),
          ]),
          Text(
            'Php ${budget.toStringAsFixed(2)}',
          ),
        ],
      ),
    );
  }
}
