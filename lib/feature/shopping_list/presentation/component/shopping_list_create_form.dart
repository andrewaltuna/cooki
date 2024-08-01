import 'package:cooki/common/component/button/primary_button.dart';
import 'package:cooki/common/component/form/custom_form_field.dart';
import 'package:cooki/common/theme/app_text_styles.dart';
import 'package:cooki/feature/shopping_list/presentation/view_model/shopping_list_catalog_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ShoppingListCreateForm extends HookWidget {
  const ShoppingListCreateForm({
    required this.onSubmit,
    this.title = 'Create Shopping List',
    this.hasBudgetField = true,
    this.onSuccess,
    super.key,
  });

  static final _formKey = GlobalKey<FormState>();

  final String title;
  final bool hasBudgetField;
  final void Function(
    String name,
    double budget,
  ) onSubmit;
  final VoidCallback? onSuccess;

  void _onCreate(
    BuildContext context, {
    required String name,
    required String budget,
  }) {
    FocusScope.of(context).unfocus();

    if (_formKey.currentState!.validate()) {
      onSubmit(
        name,
        double.tryParse(budget) ?? 0.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final nameController = useTextEditingController();
    final budgetController = useTextEditingController();

    return BlocConsumer<ShoppingListCatalogViewModel, ShoppingListCatalogState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status.isSuccess) {
          onSuccess?.call();
        }
      },
      builder: (context, state) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: AppTextStyles.titleMedium,
          ),
          const SizedBox(height: 24),
          _CreateForm(
            formKey: _formKey,
            nameController: nameController,
            budgetController: budgetController,
            hasBudgetField: hasBudgetField,
          ),
          const SizedBox(height: 16.0),
          PrimaryButton(
            label: 'Create',
            isLoading: state.status.isLoading,
            onPress: () => _onCreate(
              context,
              name: nameController.text,
              budget: budgetController.text,
            ),
          ),
        ],
      ),
    );
  }
}

class _CreateForm extends StatelessWidget {
  const _CreateForm({
    required this.formKey,
    required this.nameController,
    required this.budgetController,
    required this.hasBudgetField,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController budgetController;
  final bool hasBudgetField;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
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
              icon: Icons.monetization_on,
              textInputAction: TextInputAction.next,
              hintText: 'Budget (in PHP)',
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
        ],
      ),
    );
  }
}
