import 'package:collection/collection.dart';
import 'package:cooki/common/component/button/primary_button.dart';
import 'package:cooki/common/component/dropdown/custom_dropdown_menu.dart';
import 'package:cooki/common/component/form/custom_form_field.dart';
import 'package:cooki/common/screen/loading_screen.dart';
import 'package:cooki/common/theme/app_text_styles.dart';
import 'package:cooki/feature/product/data/model/product.dart';
import 'package:cooki/feature/product/presentation/view_model/product_view_model.dart';
import 'package:cooki/feature/shopping_list/data/model/input/shopping_list_item_input.dart';
import 'package:cooki/feature/shopping_list/presentation/view_model/shopping_list_item_form_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

const _productEmptyError = 'Product cannot be empty';
const _quantityEmptyError = 'Quantity cannot be empty';
const _labelEmptyError = 'Label cannot be empty';

class ShoppingListItemForm extends HookWidget {
  const ShoppingListItemForm({
    super.key,
    required this.onSubmit,
  });

  static final _formKey = GlobalKey<FormState>();

  final void Function(
    ShoppingListFormOutput input,
  ) onSubmit;

  void _onLabelChange(BuildContext context, String value) {
    context.read<ShoppingListItemFormViewModel>()
      ..add(
        const ItemFormLabelErrorChanged(),
      )
      ..add(
        ItemFormLabelChanged(
          value,
        ),
      );
  }

  void _onQuantityChange(BuildContext context, String value) {
    final quantity = int.tryParse(value);
    if (quantity == null) return;

    context.read<ShoppingListItemFormViewModel>()
      ..add(
        const ItemFormQuantityErrorChanged(),
      )
      ..add(
        ItemFormQuantityChanged(
          quantity,
        ),
      );
  }

  void _onProductSelected(BuildContext context, Product? value) {
    if (value == null) {
      context.read<ShoppingListItemFormViewModel>().add(
            const ItemFormProductIdErrorChanged(
              _productEmptyError,
            ),
          );
      return;
    }

    context.read<ShoppingListItemFormViewModel>()
      ..add(const ItemFormProductIdErrorChanged())
      ..add(
        ItemFormProductSelected(
          value.id,
        ),
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
    final viewModel = context.read<ShoppingListItemFormViewModel>();

    return BlocBuilder<ShoppingListItemFormViewModel,
        ShoppingListItemFormState>(
      builder: (context, state) {
        if (state.status.isInitial) {
          return const LoadingScreen();
        }

        final products = context.read<ProductViewModel>().state.products;
        final initialProduct = products
            .firstWhereOrNull((product) => product.id == state.productId);

        return Container(
          padding: const EdgeInsets.symmetric(
            vertical: 24.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomFormField(
                      icon: Icons.edit_outlined,
                      initialText: state.label,
                      hintText: 'Item Name',
                      textInputAction: TextInputAction.next,
                      onChanged: (value) => _onLabelChange(context, value),
                      errorText:
                          state.labelError.isEmpty ? null : state.labelError,
                      validator: (value) {
                        if (value == '') {
                          viewModel.add(
                            const ItemFormLabelErrorChanged(
                              _labelEmptyError,
                            ),
                          );
                        }

                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    CustomFormField(
                      icon: Icons.label_outline,
                      initialText: state.quantity.toString(),
                      hintText: 'Quantity',
                      onChanged: (value) => _onQuantityChange(context, value),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      errorText: state.quantityError.isEmpty
                          ? null
                          : state.quantityError,
                      validator: (value) {
                        if (value == '') {
                          viewModel.add(
                            const ItemFormQuantityErrorChanged(
                              _quantityEmptyError,
                            ),
                          );
                        }

                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
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
                      Text(
                        state.productIdError,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: Color(0xFFCE352A),
                        ),
                      ),
                    ]
                  ],
                ),
              ),
              PrimaryButton(
                label: 'Save',
                onPress: () => _onSubmit(context),
              ),
            ],
          ),
        );
      },
    );
  }
}
