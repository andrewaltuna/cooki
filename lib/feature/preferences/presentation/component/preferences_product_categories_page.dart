import 'package:cooki/feature/preferences/data/enum/product_category.dart';
import 'package:cooki/feature/preferences/presentation/component/preferences_selectable_item.dart';
import 'package:cooki/feature/preferences/presentation/component/preferences_selectable_section.dart';
import 'package:cooki/feature/preferences/presentation/view_model/preferences_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PreferencesProductCategoriesPage extends StatelessWidget {
  const PreferencesProductCategoriesPage({
    required this.items,
    super.key,
  });

  static const _categories = ProductCategory.values;

  final List<ProductCategory> items;

  @override
  Widget build(BuildContext context) {
    return PreferencesSelectableSection(
      label: 'Product Categories',
      description: 'Select your favorite product categories',
      builder: (index) {
        final category = _categories[index];

        final isSelected = items.contains(category);

        return PreferencesSelectableItem(
          isSelected: isSelected,
          label: category.displayLabel,
          icon: category.icon,
          onSelected: () => context.read<PreferencesViewModel>().add(
                PreferencesProductCategorySelected(category),
              ),
        );
      },
      itemCount: _categories.length,
    );
  }
}
