import 'package:cooki/feature/shopping_list/presentation/component/shopping_list_form.dart';
import 'package:cooki/feature/shopping_list/presentation/view_model/shopping_list_catalog/shopping_list_catalog_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ShoppingListCreateForm extends HookWidget {
  const ShoppingListCreateForm({
    required this.onSubmit,
    this.title = 'Create Shopping List',
    this.buttonLabel = 'Create',
    this.hasBudgetField = true,
    this.onSuccess,
    super.key,
  });

  final String title;
  final String buttonLabel;
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
    onSubmit(
      name,
      double.tryParse(budget) ?? 0.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    final nameController = useTextEditingController();
    final budgetController = useTextEditingController();

    return BlocConsumer<ShoppingListCatalogViewModel, ShoppingListCatalogState>(
      listenWhen: (previous, current) =>
          previous.status != current.status && current.status.isSuccess,
      listener: (_, __) => onSuccess?.call(),
      builder: (context, state) => ShoppingListForm(
        nameController: nameController,
        budgetController: budgetController,
        title: title,
        buttonLabel: buttonLabel,
        hasBudgetField: hasBudgetField,
        isSubmitting: state.status.isLoading,
        onSubmit: () => _onCreate(
          context,
          name: nameController.text,
          budget: budgetController.text,
        ),
      ),
    );
  }
}
