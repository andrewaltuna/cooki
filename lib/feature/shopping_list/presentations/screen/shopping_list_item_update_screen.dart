import 'package:cooki/common/component/form/custom_form_field.dart';
import 'package:cooki/common/component/main_scaffold.dart';
import 'package:cooki/common/navigation/app_routes.dart';
import 'package:cooki/common/screen/error_screen.dart';
import 'package:cooki/common/screen/loading_screen.dart';
import 'package:cooki/common/theme/app_text_styles.dart';
import 'package:cooki/feature/product/data/model/product.dart';
import 'package:cooki/feature/product/presentation/view_model/product_view_model.dart';
import 'package:cooki/feature/shopping_list/data/di/shopping_list_service_locator.dart';
import 'package:cooki/feature/shopping_list/data/model/input/shopping_list_item_input.dart';
import 'package:cooki/feature/shopping_list/data/model/input/update_shopping_list_item_input.dart';
import 'package:cooki/feature/shopping_list/data/model/shopping_list_item.dart';
import 'package:cooki/feature/shopping_list/presentations/view_model/shopping_list_item_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

class ShoppingListItemUpdateScreen extends HookWidget {
  const ShoppingListItemUpdateScreen({
    super.key,
    required this.shoppingListId,
    required this.shoppingListItemId,
  });

  final String shoppingListId;
  final String shoppingListItemId;

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      body: BlocProvider(
        create: (_) => ShoppingListItemViewModel(shoppingListRepository)
          ..add(
            ShoppingListItemRequested(
              shoppingListItemId: shoppingListItemId,
            ),
          ),
        child: _ShoppingListItemUpdateScreenContent(
          shoppingListId: shoppingListItemId,
          shoppingListItemId: shoppingListItemId,
        ),
      ),
    );
  }
}

class _ShoppingListItemUpdateScreenContent extends StatelessWidget {
  const _ShoppingListItemUpdateScreenContent({
    super.key,
    required this.shoppingListId,
    required this.shoppingListItemId,
  });

  final String shoppingListId;
  final String shoppingListItemId;

  @override
  Widget build(BuildContext context) {
    final (products, isFetchingProducts) = context.select(
      (ProductViewModel viewModel) => (
        viewModel.state.products,
        viewModel.state.isInitialLoading,
      ),
    );

    final (item, isFetchingItem) = context.select(
      (ShoppingListItemViewModel viewModel) => (
        viewModel.state.item,
        viewModel.state.isInitialLoading,
      ),
    );

    if (isFetchingItem || isFetchingProducts) {
      return LoadingScreen();
    } else if (item == null) {
      return ErrorScreen(
        errorMessage: 'Not found',
        path:
            Uri(path: '${AppRoutes.shoppingLists}/$shoppingListId').toString(),
      );
    }

    return BlocListener<ShoppingListItemViewModel, ShoppingListItemState>(
      listener: (context, state) {
        if (state.submissionStatus.isSuccess) {
          context.go(
            Uri(path: '${AppRoutes.shoppingLists}/$shoppingListId').toString(),
          );
        }
      },
      child: Column(
        children: [
          _ShoppingListItemUpdateHeader(
              shoppingListId: shoppingListId,
              shoppingListItemId: shoppingListItemId),
          ShoppingListItemUpdateForm(
            productList: products,
            selectedShoppingListItem: item,
            shoppingListId: shoppingListId,
          ),
        ],
      ),
    );
  }
}

class _ShoppingListItemUpdateHeader extends StatelessWidget {
  const _ShoppingListItemUpdateHeader({
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
      context.read<ShoppingListItemViewModel>().add(
            ShoppingListItemDeleted(
              id: itemId,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12.0,
          vertical: 16.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    context.go(
                      Uri(
                        path: '${AppRoutes.shoppingLists}/$shoppingListId',
                      ).toString(),
                    );
                  },
                  icon: Icon(
                    Icons.arrow_back_sharp,
                  ),
                ),
                const SizedBox(
                  width: 12.0,
                ),
                Text(
                  "Item Details",
                  style: AppTextStyles.titleLarge,
                ),
              ],
            ),
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
        ),
      ),
    );
  }
}

class ShoppingListItemUpdateForm extends HookWidget {
  const ShoppingListItemUpdateForm({
    super.key,
    required this.shoppingListId,
    required this.productList,
    required this.selectedShoppingListItem,
  });

  final String shoppingListId;
  final ShoppingListItem selectedShoppingListItem;
  final List<Product> productList;
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

      context.read<ShoppingListItemViewModel>().add(
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
        label: selectedShoppingListItem.label,
        productId: selectedShoppingListItem.product.id,
        quantity: selectedShoppingListItem.quantity,
      ),
    );

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
                  initialSelection: productList.firstWhere(
                      (product) => product.id == formInput.value.productId),
                  enableFilter: true,
                  requestFocusOnTap: true,
                  hintText: "Product",
                  onSelected: (value) =>
                      formInput.value = formInput.value.copyWith(
                    productId: value?.id ?? formInput.value.productId,
                  ),
                  dropdownMenuEntries: productList
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
              selectedShoppingListItem.id,
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
