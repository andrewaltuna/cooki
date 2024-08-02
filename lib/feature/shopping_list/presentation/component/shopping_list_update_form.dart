import 'package:cooki/common/component/button/primary_button.dart';
import 'package:cooki/common/component/form/custom_form_field.dart';
import 'package:cooki/common/theme/app_text_styles.dart';
import 'package:cooki/feature/shopping_list/presentation/view_model/shopping_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ShoppingListUpdateForm extends HookWidget {
  const ShoppingListUpdateForm({
    required this.onSubmit,
    required this.initialName,
    required this.initialBudget,
    this.onSuccess,
    super.key,
  });

  static final _formKey = GlobalKey<FormState>();

  final String initialName;
  final double initialBudget;
  final void Function(
    String shoppingListId,
    String name,
    double budget,
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
        shoppingListId,
        name,
        double.tryParse(budget) ?? 0.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final nameController = useTextEditingController(text: initialName);
    final budgetController =
        useTextEditingController(text: initialBudget.toString());

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
          _UpdateForm(
            formKey: _formKey,
            nameController: nameController,
            budgetController: budgetController,
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

class _UpdateForm extends StatelessWidget {
  const _UpdateForm({
    required this.formKey,
    required this.nameController,
    required this.budgetController,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController budgetController;

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
      ),
    );
  }
}
