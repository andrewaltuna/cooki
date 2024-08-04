import 'package:cooki/feature/shopping_list/presentation/component/shopping_list_form.dart';
import 'package:cooki/feature/shopping_list/presentation/view_model/shopping_list/shopping_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ShoppingListUpdateForm extends HookWidget {
  const ShoppingListUpdateForm({
    required this.onSubmit,
    required this.shoppingListId,
    required this.initialName,
    required this.initialBudget,
    this.onSuccess,
    super.key,
  });

  final String initialName;
  final double initialBudget;
  final String shoppingListId;
  final void Function(
    String name,
    double budget,
    String shoppingListId,
  ) onSubmit;
  final VoidCallback? onSuccess;

  void _onUpdate(
    BuildContext context, {
    required String name,
    required String budget,
  }) {
    onSubmit(
      name,
      double.tryParse(budget) ?? 0,
      shoppingListId,
    );
  }

  @override
  Widget build(BuildContext context) {
    final nameController = useTextEditingController(text: initialName);
    final budgetController = useTextEditingController(
      text: initialBudget.toString(),
    );

    return BlocConsumer<ShoppingListViewModel, ShoppingListState>(
      listenWhen: (previous, current) =>
          previous.updateStatus != current.updateStatus &&
          current.updateStatus.isSuccess,
      listener: (_, __) => onSuccess?.call(),
      builder: (context, state) => ShoppingListForm(
        nameController: nameController,
        budgetController: budgetController,
        title: 'Update Shopping List',
        buttonLabel: 'Update',
        isSubmitting: state.updateStatus.isLoading,
        onSubmit: () => _onUpdate(
          context,
          name: nameController.text,
          budget: budgetController.text,
        ),
      ),
    );
  }
}
