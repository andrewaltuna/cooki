import 'package:cooki/common/component/button/primary_button.dart';
import 'package:cooki/common/component/form/custom_form_field.dart';
import 'package:cooki/common/theme/app_text_styles.dart';
import 'package:cooki/feature/shopping_list/presentation/view_model/shopping_list/shopping_list_view_model.dart';
import 'package:cooki/feature/shopping_list/presentation/view_model/shopping_list_catalog/shopping_list_catalog_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ShoppingListForm extends HookWidget {
  const ShoppingListForm({
    required this.onSubmit,
    required this.title,
    this.hasBudgetField = true,
    this.initialName = '',
    this.initialBudget = 0.0,
    this.shoppingListId,
    this.onSuccess,
    super.key,
  });

  static final _formKey = GlobalKey<FormState>();

  final String title;
  final bool hasBudgetField;
  final String initialName;
  final double initialBudget;
  final String? shoppingListId;
  final void Function(
    String name,
    double budget,
    String shoppingListId,
  ) onSubmit;
  final VoidCallback? onSuccess;

  void _onUpdate(
    BuildContext context, {
    required String shoppingListId,
    required String name,
    required String budget,
  }) {
    FocusScope.of(context).unfocus();

    if (_formKey.currentState!.validate()) {
      onSubmit(
        name,
        double.tryParse(budget) ?? 0.0,
        shoppingListId,
      );
    }
  }

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
        '',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final nameController = useTextEditingController(text: initialName);
    final budgetController =
        useTextEditingController(text: initialBudget.toString());
    final isCreating = shoppingListId == null;

    if (isCreating) {
      return BlocConsumer<ShoppingListCatalogViewModel,
          ShoppingListCatalogState>(
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
            _FormContent(
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
    } else {
      return BlocConsumer<ShoppingListViewModel, ShoppingListState>(
        listenWhen: (previous, current) =>
            previous.updateStatus != current.updateStatus,
        listener: (context, state) {
          if (state.updateStatus.isSuccess) {
            onSuccess?.call();
          }
        },
        builder: (context, state) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Update Shopping List',
              style: AppTextStyles.titleMedium,
            ),
            const SizedBox(height: 24),
            _FormContent(
              formKey: _formKey,
              nameController: nameController,
              budgetController: budgetController,
              hasBudgetField: true,
            ),
            const SizedBox(height: 16.0),
            PrimaryButton(
              label: 'Update',
              isLoading: state.status.isLoading,
              onPress: () => _onUpdate(
                context,
                shoppingListId: state.shoppingList.id,
                name: nameController.text,
                budget: budgetController.text,
              ),
            ),
          ],
        ),
      );
    }
  }
}

class _FormContent extends StatelessWidget {
  const _FormContent({
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
