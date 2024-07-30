import 'package:collection/collection.dart';
import 'package:cooki/common/component/form/custom_form_field.dart';
import 'package:cooki/common/theme/app_text_styles.dart';
import 'package:cooki/feature/product/data/model/product.dart';
import 'package:cooki/feature/product/presentation/view_model/product_view_model.dart';
import 'package:cooki/feature/shopping_list/data/model/input/shopping_list_item_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ShoppingListItemForm extends HookWidget {
  const ShoppingListItemForm({
    super.key,
    required this.initialValue,
    required this.onSubmit,
  });

  static final _formKey = GlobalKey<FormState>();

  final ShoppingListItemInput initialValue;
  final void Function(ShoppingListItemInput) onSubmit;

  @override
  Widget build(BuildContext context) {
    final formInput = useState<ShoppingListItemInput>(initialValue);

    final products = context.read<ProductViewModel>().state.products;
    final initialProduct = products
        .firstWhereOrNull((product) => product.id == formInput.value.productId);

    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 12.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                CustomFormField(
                  initialText: formInput.value.label,
                  hintText: 'Item Name',
                  icon: Icons.list,
                  textInputAction: TextInputAction.next,
                  onChanged: (value) =>
                      formInput.value = formInput.value.copyWith(
                    label: value,
                  ),
                ),
                const SizedBox(
                  height: 12.0,
                ),
                CustomFormField(
                  initialText: formInput.value.quantity.toString(),
                  hintText: 'Quantity',
                  icon: Icons.list,
                  onChanged: (value) =>
                      formInput.value = formInput.value.copyWith(
                    quantity: int.tryParse(value) ?? 0,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                ),
                DropdownMenu<Product>(
                  initialSelection: initialProduct,
                  enableFilter: true,
                  requestFocusOnTap: true,
                  hintText: 'Product',
                  onSelected: (value) =>
                      formInput.value = formInput.value.copyWith(
                    productId: value?.id,
                  ),
                  dropdownMenuEntries: products
                      .map(
                        (product) => DropdownMenuEntry(
                          value: product,
                          label: product.brand,
                          style: MenuItemButton.styleFrom(
                            textStyle: AppTextStyles.bodyMedium,
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                onSubmit(formInput.value);
              }
            },
            child: const Text(
              'Save',
            ),
          ),
        ],
      ),
    );
  }
}
