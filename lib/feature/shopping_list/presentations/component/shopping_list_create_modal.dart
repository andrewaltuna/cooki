import 'package:cooki/common/component/form/custom_form_field.dart';
import 'package:cooki/common/theme/app_colors.dart';
import 'package:cooki/common/theme/app_text_styles.dart';
import 'package:cooki/feature/shopping_list/presentations/view_model/shopping_list_catalog_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
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
      context.read<ShoppingListCatalogViewModel>().add(
            ShoppingListCreated(
              name: nameController.text,
              budget: budgetController.text,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final nameInputController = useTextEditingController();
    final budgetInputController = useTextEditingController();

    return BlocListener<ShoppingListCatalogViewModel, ShoppingListCatalogState>(
      listener: (context, state) {
        if (state.status.isSuccess) {
          Navigator.pop(context);
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Create Shopping List',
              style: AppTextStyles.titleMedium,
            ),
            const SizedBox(
              height: 24,
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
                      FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: AppColors.backgroundSecondary,
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 24.0,
                      )),
                  onPressed: () => _onClose(context),
                  child: Text(
                    "Close",
                    style: AppTextStyles.titleSmall.copyWith(
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
                const SizedBox(width: 16.0),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: AppColors.accent,
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 24.0,
                    ),
                  ),
                  child: Text(
                    "Create",
                    style: AppTextStyles.titleSmall.copyWith(
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  onPressed: () => _onCreate(
                      context, nameInputController, budgetInputController),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
