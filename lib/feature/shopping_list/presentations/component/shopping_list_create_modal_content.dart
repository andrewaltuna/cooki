import 'package:cooki/common/component/form/custom_form_field.dart';
import 'package:cooki/common/theme/app_text_styles.dart';
import 'package:cooki/feature/shopping_list/presentations/view_model/shopping_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ShoppingListCreateModalContent extends HookWidget {
  const ShoppingListCreateModalContent({super.key});

  static final _formKey = GlobalKey<FormState>();
  void _onClose(BuildContext context) {
    Navigator.pop(context);
  }

  void _onCreate(TextEditingController controller, BuildContext context) {
    FocusScope.of(context).unfocus();
    String name = controller.text;
    if (_formKey.currentState!.validate()) {
      context.read<ShoppingListViewModel>().add(
            ShoppingListCreated(name),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();
    return BlocListener<ShoppingListViewModel, ShoppingListState>(
      listener: (context, state) {},
      child: Column(
        children: [
          Text(
            'Create Shopping List',
            style: AppTextStyles.titleMedium,
          ),
          Form(
            key: _formKey,
            child: CustomFormField(
              controller: controller,
              hintText: "List name",
              icon: Icons.list,
              textInputAction: TextInputAction.next,
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
                onPressed: () => _onCreate(controller, context),
              )
            ],
          )
        ],
      ),
    );
  }
}
