import 'package:collection/collection.dart';
import 'package:cooki/common/component/form/custom_form_field.dart';
import 'package:cooki/common/component/main_scaffold.dart';
import 'package:cooki/common/navigation/app_routes.dart';
import 'package:cooki/common/screen/error_screen.dart';
import 'package:cooki/common/screen/loading_screen.dart';
import 'package:cooki/common/theme/app_text_styles.dart';
import 'package:cooki/feature/product/data/model/product.dart';
import 'package:cooki/feature/product/presentation/view_model/product_view_model.dart';
import 'package:cooki/feature/shopping_list/data/model/input/shopping_list_item_input.dart';
import 'package:cooki/feature/shopping_list/data/model/input/update_shopping_list_item_input.dart';
import 'package:cooki/feature/shopping_list/data/model/shopping_list_item.dart';
import 'package:cooki/feature/shopping_list/presentation/view_model/shopping_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

class ShoppingListItemUpdateView extends StatelessWidget {
  const ShoppingListItemUpdateView({
    super.key,
    required this.shoppingListId,
    required this.shoppingListItemId,
  });

  final String shoppingListId;
  final String shoppingListItemId;

  void _onSubmitted(
    BuildContext context,
    String itemId,
  ) {
    {
      context.read<ShoppingListViewModel>().add(
            ShoppingListItemDeleted(
              id: itemId,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShoppingListViewModel, ShoppingListState>(
      listener: (context, state) {
        if (state.updateItemStatus.isSuccess ||
            state.deleteItemStatus.isSuccess) {
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        final status = context.read<ShoppingListViewModel>().state.status;

        final shoppingList =
            context.read<ShoppingListViewModel>().state.shoppingList;

        final shoppingListItem = shoppingList?.items
            .firstWhereOrNull((item) => item.id == shoppingListItemId);

        if (status.isLoading) {
          return const LoadingScreen();
        } else if (status.isError || shoppingListItem == null) {
          return const ErrorScreen(
            errorMessage: 'Not found',
            path: AppRoutes.shoppingLists,
          );
        }
        return MainScaffold(
          title: "Update Item",
          leading: IconButton(
            onPressed: () {
              context.go(
                '${AppRoutes.shoppingLists}/$shoppingListId',
              );
            },
            icon: const Icon(
              Icons.arrow_back,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () => _onSubmitted(
                context,
                shoppingListItemId,
              ),
              icon: Icon(
                Icons.delete,
              ),
            ),
          ],
          body: _ItemUpdateForm(
            shoppingListId: shoppingListId,
            shoppingListItem: shoppingListItem,
          ),
        );
      },
    );
  }
}

class _ItemUpdateForm extends HookWidget {
  const _ItemUpdateForm({
    super.key,
    required this.shoppingListId,
    required this.shoppingListItem,
  });

  final String shoppingListId;
  final ShoppingListItem shoppingListItem;
  static final _formKey = GlobalKey<FormState>();

  void _onSubmit(
    BuildContext context,
    ShoppingListItemInput formInput,
    String itemId,
  ) {
    if (_formKey.currentState!.validate()) {
      final input = UpdateShoppingListItemInput(
        id: itemId,
        label: formInput.label,
        productId: formInput.productId,
        quantity: formInput.quantity,
      );

      context.read<ShoppingListViewModel>().add(
            ShoppingListItemUpdated(
              input: input,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final formInput = useState<ShoppingListItemInput>(
      ShoppingListItemInput(
        label: shoppingListItem.label,
        productId: shoppingListItem.product.id,
        quantity: shoppingListItem.quantity,
      ),
    );

    final products = context.read<ProductViewModel>().state.products;
    final selectedProduct = products
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
                  hintText: "Item Name",
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
                  hintText: "Quantity",
                  icon: Icons.list,
                  onChanged: (value) =>
                      formInput.value = formInput.value.copyWith(
                    quantity: int.parse(value),
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                ),
                DropdownMenu<Product>(
                  initialSelection: selectedProduct,
                  enableFilter: true,
                  requestFocusOnTap: true,
                  hintText: "Product",
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
            onPressed: () => _onSubmit(
              context,
              formInput.value,
              shoppingListItem.id,
            ),
            child: Text(
              "Save",
            ),
          ),
        ],
      ),
    );
  }
}
