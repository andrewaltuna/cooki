import 'package:cooki/common/component/button/primary_button.dart';
import 'package:cooki/common/theme/app_text_styles.dart';
import 'package:cooki/feature/shopping_list/data/model/shopping_list_item.dart';
import 'package:flutter/material.dart';

class ItemRestrictions extends StatelessWidget {
  const ItemRestrictions({
    super.key,
    required this.item,
  });

  final ShoppingListItem item;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Restrictions',
            style: AppTextStyles.titleMedium,
          ),
          const SizedBox(height: 4),
          _RestrictionInformation(
            label: 'Dietary restrictions',
            items: item.dietaryRestrictions
                .map((restriction) => restriction.displayLabel)
                .toList(),
          ),
          const SizedBox(height: 4),
          _RestrictionInformation(
            label: 'Medications',
            items: item.medications
                .map((medication) => medication.displayLabel)
                .toList(),
          ),
          const SizedBox(height: 16),
          PrimaryButton(
            label: 'View Alternative Products',
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
            onPress: () {},
            prefixIcon: const Icon(
              Icons.switch_access_shortcut,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class _RestrictionInformation extends StatelessWidget {
  const _RestrictionInformation({
    required this.items,
    required this.label,
  });

  final String label;
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label this interferes with:',
          style: AppTextStyles.bodyMedium,
        ),
        for (var item in items)
          Padding(
            padding: const EdgeInsets.only(
              left: 8.0,
              top: 4.0,
            ),
            child: Text(
              '\u2022 $item',
              style: AppTextStyles.bodyMedium,
            ),
          ),
      ],
    );
  }
}
