import 'package:cooki/common/component/button/primary_button.dart';
import 'package:cooki/common/component/form/custom_form_field.dart';
import 'package:cooki/common/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ShoppingListForm extends HookWidget {
  const ShoppingListForm({
    required this.title,
    required this.buttonLabel,
    this.hasBudgetField = true,
    this.nameController,
    this.budgetController,
    this.isSubmitting = false,
    this.onSubmit,
    super.key,
  });

  static final _formKey = GlobalKey<FormState>();

  final String title;
  final VoidCallback? onSubmit;
  final TextEditingController? nameController;
  final TextEditingController? budgetController;
  final bool hasBudgetField;
  final String buttonLabel;
  final bool isSubmitting;

  void _onSubmit(BuildContext context) {
    FocusScope.of(context).unfocus();

    if (_formKey.currentState!.validate()) {
      onSubmit?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: AppTextStyles.titleMedium,
          ),
          const SizedBox(height: 24),
          CustomFormField(
            controller: nameController,
            hintText: 'Name',
            icon: Icons.list,
            textInputAction: TextInputAction.next,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Name cannot be empty';
              }

              return null;
            },
          ),
          if (hasBudgetField) ...[
            const SizedBox(height: 16),
            CustomFormField(
              controller: budgetController,
              keyboardType: TextInputType.number,
              icon: Icons.attach_money,
              textInputAction: TextInputAction.next,
              hintText: 'Budget (USD)',
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                  RegExp(r'^\d*\.?\d*'),
                ),
              ],
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Budget cannot be empty';
                }

                return null;
              },
            ),
          ],
          const SizedBox(height: 16.0),
          PrimaryButton(
            label: buttonLabel,
            isLoading: isSubmitting,
            onPress: () => _onSubmit(context),
          ),
        ],
      ),
    );
  }
}
