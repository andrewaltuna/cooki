import 'package:collection/collection.dart';
import 'package:cooki/common/component/button/ink_well_button.dart';
import 'package:cooki/common/component/custom_dropdown_menu.dart';
import 'package:cooki/common/theme/app_colors.dart';
import 'package:cooki/common/theme/app_text_styles.dart';
import 'package:cooki/feature/preferences/data/enum/medication.dart';
import 'package:cooki/feature/preferences/presentation/view_model/preferences_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class PreferencesMedicationsPage extends HookWidget {
  const PreferencesMedicationsPage({
    required this.items,
    super.key,
  });

  static const _medications = Medication.values;

  final List<Medication> items;

  @override
  Widget build(BuildContext context) {
    final dropdownController = useTextEditingController();

    // Limit selectable values to those not already selected
    final filteredValues =
        _medications.where((element) => !items.contains(element)).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Medications',
          style: AppTextStyles.titleSmall,
        ),
        const SizedBox(height: 4),
        Text(
          "Let us know if you're taking any medications",
          style: AppTextStyles.bodyMedium,
        ),
        const SizedBox(height: 16),
        _MedicationDropdown(
          controller: dropdownController,
          values: filteredValues,
        ),
        const SizedBox(height: 12),
        Expanded(
          child: _TaggedMedications(
            items: items,
          ),
        ),
      ],
    );
  }
}

class _MedicationDropdown extends StatelessWidget {
  const _MedicationDropdown({
    required this.controller,
    required this.values,
  });

  final TextEditingController controller;
  final List<Medication> values;

  void _onSelected(BuildContext context, Medication? value) {
    if (value == null) return;

    context.read<PreferencesViewModel>().add(
          PreferencesMedicationAdded(
            medication: value,
          ),
        );

    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomDropdownMenu(
            controller: controller,
            height: 50,
            hintText: 'Generic name',
            onSelected: (value) => _onSelected(context, value),
            entries: values
                .map(
                  (medication) => CustomDropdownMenuEntry(
                    value: medication,
                    label: medication.displayLabel,
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}

class _TaggedMedications extends StatelessWidget {
  const _TaggedMedications({
    required this.items,
  });

  final List<Medication> items;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Wrap(
        spacing: 6,
        runSpacing: 6,
        children: items
            .mapIndexed(
              (index, medication) => _MedicationItem(
                medication: medication,
                onPressed: () => context.read<PreferencesViewModel>().add(
                      PreferencesMedicationRemoved(index),
                    ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _MedicationItem extends StatelessWidget {
  const _MedicationItem({
    required this.medication,
    required this.onPressed,
  });

  final Medication medication;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWellButton(
      onPressed: onPressed,
      circularBorderRadius: 8,
      circularPadding: 8,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            medication.displayLabel,
            style: AppTextStyles.bodySmall,
          ),
          const SizedBox(width: 4),
          const Icon(
            Icons.close,
            size: 16,
            color: AppColors.fontPrimary,
          ),
        ],
      ),
    );
  }
}
