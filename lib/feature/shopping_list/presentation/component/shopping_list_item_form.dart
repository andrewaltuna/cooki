import 'package:cooki/common/component/button/primary_button.dart';
import 'package:cooki/common/component/dropdown/custom_dropdown_menu.dart';
import 'package:cooki/common/component/form/custom_form_field.dart';
import 'package:cooki/common/screen/loading_screen.dart';
import 'package:cooki/common/theme/app_colors.dart';
import 'package:cooki/common/theme/app_text_styles.dart';
import 'package:cooki/feature/product/data/model/product.dart';
import 'package:cooki/feature/product/presentation/view_model/product_view_model.dart';
import 'package:cooki/feature/shopping_list/data/model/shopping_list_item_form_output.dart';
import 'package:cooki/feature/shopping_list/presentation/view_model/shopping_list_item_form/shopping_list_item_form_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

const _productEmptyError = 'Product cannot be empty';
const _quantityEmptyError = 'Quantity cannot be empty';
const _quantityInvalidError = 'Quantity must be at least 1';
const _labelEmptyError = 'Label cannot be empty';

class ShoppingListItemForm extends HookWidget {
  const ShoppingListItemForm({
    super.key,
    required this.onSubmit,
  });

  static final _formKey = GlobalKey<FormState>();

  final void Function(
    ShoppingListItemFormOutput input,
  ) onSubmit;

  void _onLabelChanged(
    BuildContext context,
    String value,
  ) {
    context
        .read<ShoppingListItemFormViewModel>()
        .add(ItemFormLabelChanged(value));
  }

  void _onQuantityChanged(
    BuildContext context,
    String value,
  ) {
    final quantity = int.tryParse(value);
    if (quantity == null) return;

    context.read<ShoppingListItemFormViewModel>().add(
          ItemFormQuantityChanged(quantity),
        );
  }

  void _onProductSelected(
    BuildContext context,
    Product? value,
  ) {
    if (value == null) return;

    context.read<ShoppingListItemFormViewModel>().add(
          ItemFormProductSelected(value.id),
        );
  }

  void _onSubmit(BuildContext context) {
    final viewModel = context.read<ShoppingListItemFormViewModel>();
    final isProductIdValid = viewModel.state.productId.isNotEmpty;
    final isValid = _formKey.currentState!.validate() && isProductIdValid;

    if (!isProductIdValid) {
      viewModel.add(
        const ItemFormProductIdErrorChanged(
          _productEmptyError,
        ),
      );
    }

    if (!isValid) return;

    onSubmit(
      viewModel.state.toFormOutput(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ShoppingListItemFormViewModel>().state;

    if (state.status.isInitial) {
      return const LoadingScreen();
    }

    final (
      products,
      initialProduct,
    ) = context.select(
      (ProductViewModel viewModel) => (
        viewModel.state.products,
        viewModel.state.productById(state.productId),
      ),
    );

    final initialQuantity =
        state.quantity > 0 ? state.quantity.toString() : null;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CustomFormField(
                      icon: Icons.edit_outlined,
                      initialText: state.label,
                      hintText: 'Label',
                      textInputAction: TextInputAction.next,
                      onChanged: (value) => _onLabelChanged(context, value),
                      validator: (value) {
                        if (value == '') return _labelEmptyError;

                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    CustomFormField(
                      icon: Icons.numbers,
                      initialText: initialQuantity,
                      hintText: 'Quantity',
                      onChanged: (value) => _onQuantityChanged(context, value),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      validator: (value) {
                        if (value == '') return _quantityEmptyError;

                        if (int.parse(value ?? '') <= 0) {
                          return _quantityInvalidError;
                        }

                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    CustomDropdownMenu(
                      initialSelection: initialProduct,
                      hintText: 'Select Product',
                      onSelected: (value) => _onProductSelected(context, value),
                      entries: products
                          .map(
                            (product) => CustomDropdownMenuEntry(
                              value: product,
                              label: product.brand,
                            ),
                          )
                          .toList(),
                    ),
                    if (state.productIdError.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: Text(
                          state.productIdError,
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.fontWarning,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            PrimaryButton(
              label: 'Save',
              onPress: () => _onSubmit(context),
            ),
          ],
        ),
      ),
    );
  }
}
