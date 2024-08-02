import 'package:cooki/common/component/button/primary_button.dart';
import 'package:cooki/common/component/form/custom_form_field.dart';
import 'package:cooki/common/theme/app_colors.dart';
import 'package:cooki/common/theme/app_text_styles.dart';
import 'package:cooki/feature/shopping_list/presentation/view_model/shopping_list/shopping_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

const _btnDefaultWidth = 120.0;
const _btnDefaultHeight = 35.0;

class ShoppingListUpdateModalContent extends HookWidget {
  const ShoppingListUpdateModalContent({
    super.key,
  });

  static final _formKey = GlobalKey<FormState>();

  void _onClose(BuildContext context) {
    Navigator.pop(context);
  }

  void _onUpdate(
    BuildContext context,
    String shoppingListId,
    TextEditingController nameController,
    TextEditingController budgetController,
  ) {
    FocusScope.of(context).unfocus();
    // TODO: Form validation
    if (_formKey.currentState!.validate()) {
      context.read<ShoppingListViewModel>().add(
            ShoppingListUpdated(
              shoppingListId: shoppingListId,
              name: nameController.text,
              budget: double.parse(budgetController.text),
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final shoppingList =
        context.read<ShoppingListViewModel>().state.shoppingList;
    final nameInputController =
        useTextEditingController(text: shoppingList.name);
    final budgetInputController =
        useTextEditingController(text: shoppingList.budget.toString());

    return BlocListener<ShoppingListViewModel, ShoppingListState>(
      listener: (context, state) {
        if (state.updateStatus.isSuccess) {
          Navigator.pop(context);
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Update Shopping List',
              style: AppTextStyles.titleMedium,
            ),
            const SizedBox(height: 24),
            _CreateForm(
              formKey: _formKey,
              nameInputController: nameInputController,
              budgetInputController: budgetInputController,
            ),
            const SizedBox(height: 16.0),
            _ModalActions(
              onClose: () => _onClose(context),
              onUpdate: () => _onUpdate(
                context,
                shoppingList.id,
                nameInputController,
                budgetInputController,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CreateForm extends StatelessWidget {
  const _CreateForm({
    required GlobalKey<FormState> formKey,
    required this.nameInputController,
    required this.budgetInputController,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  final TextEditingController nameInputController;
  final TextEditingController budgetInputController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomFormField(
            controller: nameInputController,
            hintText: 'List name',
            icon: Icons.list,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 16),
          CustomFormField(
            controller: budgetInputController,
            keyboardType: TextInputType.number,
            icon: Icons.monetization_on,
            textInputAction: TextInputAction.next,
            hintText: 'Budget (in PHP)',
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp(r'^\d*\.?\d*'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ModalActions extends StatelessWidget {
  const _ModalActions({
    required this.onClose,
    required this.onUpdate,
  });

  final Function() onClose;
  final Function() onUpdate;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        PrimaryButton(
          label: 'Close',
          onPress: onClose,
          height: _btnDefaultHeight,
          width: _btnDefaultWidth,
          style: const TextStyle(
            color: AppColors.primary,
          ),
          backgroundColor: AppColors.backgroundSecondary,
        ),
        const SizedBox(width: 16.0),
        PrimaryButton(
          label: 'Update',
          onPress: onUpdate,
          height: _btnDefaultHeight,
          width: _btnDefaultWidth,
        ),
      ],
    );
  }
}
