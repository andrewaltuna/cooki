import 'package:cooki/common/component/button/primary_button.dart';
import 'package:cooki/common/component/form/custom_form_field.dart';
import 'package:cooki/common/theme/app_colors.dart';
import 'package:cooki/common/theme/app_text_styles.dart';
import 'package:cooki/feature/shopping_list/presentation/view_model/shopping_list_catalog_view_model.dart';
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
            _CreateForm(
              formKey: _formKey,
              nameInputController: nameInputController,
              budgetInputController: budgetInputController,
            ),
            const SizedBox(
              height: 16.0,
            ),
            _ModalActions(
              onClose: () => _onClose(context),
              onCreate: () => _onCreate(
                context,
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
              FilteringTextInputFormatter.allow(
                RegExp(r'^\d*\.?\d*'),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _ModalActions extends StatelessWidget {
  const _ModalActions({
    required this.onClose,
    required this.onCreate,
  });

  final Function() onClose;
  final Function() onCreate;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        PrimaryButton(
          label: 'Close',
          onPress: onClose,
          width: 100.0,
          height: 50.0,
          bgColor: AppColors.backgroundSecondary,
        ),
        const SizedBox(width: 16.0),
        PrimaryButton(
          label: "Create",
          onPress: onCreate,
          width: 100.0,
          height: 50.0,
        ),
      ],
    );
  }
}
