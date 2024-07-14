import 'package:cooki/common/component/form/custom_form_field.dart';
import 'package:cooki/common/theme/app_text_styles.dart';
import 'package:cooki/feature/shopping_list/presentations/view_model/shopping_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ShoppingListCreateModalContent extends HookWidget {
  const ShoppingListCreateModalContent({super.key});

  static final _formKey = GlobalKey<FormState>();
  void _onClose(BuildContext context) {
    Navigator.pop(context);
  }

  void _onCreate(BuildContext context, TextEditingController nameController,
      TextEditingController budgetController) {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      context.read<ShoppingListViewModel>().add(
            ShoppingListCreated(nameController.text, budgetController.text),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final nameInputController = useTextEditingController();
    final budgetInputController = useTextEditingController();

    return BlocListener<ShoppingListViewModel, ShoppingListState>(
      listener: (context, state) {
        if (state.status.isSuccess) {
          Navigator.pop(context);
        }
      },
      child: Column(
        children: [
          Text(
            'Create Shopping List',
            style: AppTextStyles.titleMedium,
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                CustomFormField(
                  controller: nameInputController,
                  hintText: "List name",
                  icon: Icons.list,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 16),
                CustomFormField(
                  controller: budgetInputController,
                  keyboardType: TextInputType.number,
                  icon: Icons.monetization_on,
                  textInputAction: TextInputAction.next,
                  hintText: "Budget (in PHP)",
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                )
              ],
            ),
          ),
          Row(
            children: [
              TextButton(
                onPressed: () => _onClose(context),
                child: Text("Close"),
              ),
              TextButton(
                child: Text("Create"),
                onPressed: () => _onCreate(
                    context, nameInputController, budgetInputController),
              )
            ],
          )
        ],
      ),
    );
  }
}
