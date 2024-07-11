import 'package:cooki/feature/preferences/data/enum/dietary_restriction.dart';
import 'package:cooki/feature/preferences/presentation/component/preferences_selectable_item.dart';
import 'package:cooki/feature/preferences/presentation/component/preferences_selectable_section.dart';
import 'package:cooki/feature/preferences/presentation/view_model/preferences_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PreferencesDietaryRestrictionsPage extends StatelessWidget {
  const PreferencesDietaryRestrictionsPage({
    required this.items,
    super.key,
  });

  static const _restrictions = DietaryRestriction.values;

  final List<DietaryRestriction> items;

  @override
  Widget build(BuildContext context) {
    return PreferencesSelectableSection(
      label: 'Dietary Restrictions',
      description: 'Select any dietary restrictions you may have',
      builder: (index) {
        final restriction = _restrictions[index];

        final isSelected = items.contains(restriction);

        return PreferencesSelectableItem(
          isSelected: isSelected,
          label: restriction.displayLabel,
          icon: restriction.icon,
          onSelected: () => context.read<PreferencesViewModel>().add(
                PreferencesDietaryRestrictionSelected(restriction),
              ),
        );
      },
      itemCount: _restrictions.length,
    );
  }
}
