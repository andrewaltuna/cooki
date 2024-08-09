import 'package:cooki/common/component/button/custom_icon_button.dart';
import 'package:cooki/common/component/button/primary_button.dart';
import 'package:cooki/common/component/dropdown/custom_dropdown_menu.dart';
import 'package:cooki/common/component/form/custom_form_field.dart';
import 'package:cooki/common/helper/toast_helper.dart';
import 'package:cooki/common/screen/loading_screen.dart';
import 'package:cooki/common/theme/app_colors.dart';
import 'package:cooki/common/theme/app_text_styles.dart';
import 'package:cooki/feature/product/data/model/product.dart';
import 'package:cooki/feature/product/presentation/component/product_information_collapsed_view.dart';
import 'package:cooki/feature/product/presentation/view_model/product_view_model.dart';
import 'package:cooki/feature/shopping_list/data/model/shopping_list_item_form_output.dart';
import 'package:cooki/feature/shopping_list/presentation/component/shopping_list_helper.dart';
import 'package:cooki/feature/shopping_list/presentation/view_model/shopping_list_item_form/shopping_list_item_form_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

const _productEmptyError = 'Product cannot be empty';
const _quantityEmptyError = 'Quantity cannot be empty';
const _quantityInvalidError = 'Quantity must be at least 1';

class ShoppingListItemForm extends HookWidget {
  const ShoppingListItemForm({
    super.key,
    required this.onSubmit,
  });

  static final _formKey = GlobalKey<FormState>();

  final void Function(
    ShoppingListItemFormOutput input,
  ) onSubmit;

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

  void _onSectionSelected(
    BuildContext context, {
    required String? value,
    required TextEditingController productController,
  }) {
    final viewModel = context.read<ShoppingListItemFormViewModel>();

    if (value == viewModel.state.section) return;

    productController.clear();

    context.read<ShoppingListItemFormViewModel>().add(
          ItemFormSectionSelected(value ?? ''),
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
      sections,
      productsBySection,
      selectedProduct,
    ) = context.select(
      (ProductViewModel viewModel) => (
        viewModel.state.sections,
        viewModel.state.productsBySection(state.section),
        viewModel.state.productById(state.productId),
      ),
    );

    final productController = useTextEditingController(
      text: selectedProduct.name,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _FieldLabel(label: 'Section'),
                    CustomDropdownMenu(
                      hintText: 'Select Section',
                      initialSelection: state.section,
                      onSelected: (value) => _onSectionSelected(
                        context,
                        value: value,
                        productController: productController,
                      ),
                      entries: sections
                          .map(
                            (section) => CustomDropdownMenuEntry(
                              value: section,
                              label: section,
                            ),
                          )
                          .toList(),
                    ),
                    const SizedBox(height: 16),
                    const _FieldLabel(label: 'Product'),
                    Row(
                      children: [
                        Expanded(
                          child: CustomDropdownMenu(
                            refreshKey:
                                ValueKey(Object.hashAll(productsBySection)),
                            hintText: 'Select Product',
                            enabled: state.section.isNotEmpty,
                            initialSelection: selectedProduct,
                            controller: productController,
                            onSelected: (value) =>
                                _onProductSelected(context, value),
                            entries: productsBySection
                                .map(
                                  (product) => CustomDropdownMenuEntry(
                                    value: product,
                                    label: product.name,
                                    labelWidget: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 4,
                                      ),
                                      child: ProductInformationCollapsedView(
                                        product: product,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                        const SizedBox(width: 8),
                        _ViewProductButton(
                          product: selectedProduct,
                        ),
                      ],
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
                    const SizedBox(height: 16),
                    const _FieldLabel(label: 'Quantity'),
                    CustomFormField(
                      icon: Icons.numbers,
                      initialText: initialQuantity,
                      hintText: 'Quantity',
                      onChanged: (value) => _onQuantityChanged(context, value),
                      keyboardType: TextInputType.number,
                      maxLength: 4,
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

class _ViewProductButton extends StatelessWidget {
  const _ViewProductButton({
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return CustomIconButton(
      icon: Icons.visibility_outlined,
      padding: 0,
      size: 45,
      onPressed: () => product.isNotEmpty
          ? ShoppingListHelper.of(context).showProductInformationDialog(
              product,
            )
          : ToastHelper.of(context).showToast('Select a product to view'),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel({
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
        label,
        style: AppTextStyles.titleSmall,
      ),
    );
  }
}
