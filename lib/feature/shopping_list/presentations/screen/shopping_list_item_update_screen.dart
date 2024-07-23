import 'package:cooki/common/component/form/custom_form_field.dart';
import 'package:cooki/common/component/main_scaffold.dart';
import 'package:cooki/common/hook/use_on_widget_load.dart';
import 'package:cooki/common/navigation/app_routes.dart';
import 'package:cooki/common/theme/app_text_styles.dart';
import 'package:cooki/feature/product/data/model/output/product_output.dart';
import 'package:cooki/feature/product/presentation/view_model/product_event.dart';
import 'package:cooki/feature/product/presentation/view_model/product_view_model.dart';
import 'package:cooki/feature/shopping_list/data/di/shopping_list_service_locator.dart';
import 'package:cooki/feature/shopping_list/data/model/input/update_shopping_list_item_input.dart';
import 'package:cooki/feature/shopping_list/data/model/output/shopping_list_item_output.dart';
import 'package:cooki/feature/shopping_list/presentations/view_model/shopping_list_item_view_model.dart';
import 'package:cooki/feature/shopping_list/presentations/view_model/shopping_list_view_model.dart';
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
    useOnWidgetLoad(() {
      context.read<ShoppingListItemViewModel>().add(
            ShoppingListItemRequested(
              shoppingListItemId: shoppingListItemId,
            ),
          );
    });

    final (isFetchingItems, item) = context.select(
      (ShoppingListItemViewModel viewModel) => (
        viewModel.state.isInitialLoading,
        viewModel.state.item,
      ),
    );
    final (products, isFetchingProducts) = context.select(
      (ProductViewModel viewModel) => (
        viewModel.state.products,
        viewModel.state.isInitialLoading,
      ),
    );

    if (isFetchingItems || isFetchingProducts) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (item == null) {
      return Center(
        child: Column(
          children: [
            Text('Not Found'),
            TextButton(
              onPressed: () => context.go(
                Uri(
                  path: '${AppRoutes.shoppingLists}/$shoppingListId',
                ).toString(),
              ),
              child: Text('Go Back'),
            ),
          ],
        ),
      );
    }

    return MainScaffold(
      body: Column(
        children: [
          Container(
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
                          context
                              .read<ShoppingListItemViewModel>()
                              .add(const ShoppingListItemDeselected());
                          context.go(
                            Uri(
                              path:
                                  '${AppRoutes.shoppingLists}/$shoppingListId',
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
                    onPressed: () {},
                    icon: Icon(
                      Icons.menu,
                    ),
                  ),
                ],
              ),
            ),
          ),
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

class ShoppingListItemUpdateForm extends HookWidget {
  const ShoppingListItemUpdateForm({
    super.key,
    required this.shoppingListId,
    required this.productList,
    required this.selectedShoppingListItem,
  });

  final String shoppingListId;
  final ShoppingListItem selectedShoppingListItem;
  final List<ProductOutput> productList;
  static final _formKey = GlobalKey<FormState>();

  void _onSubmit(BuildContext context,
      ValueNotifier<UpdateShoppingListItemInput> formInput) {
    if (_formKey.currentState!.validate()) {
      context.read<ShoppingListItemViewModel>()
        ..add(
          ShoppingListItemUpdated(
            input: formInput.value,
          ),
        )
        ..add(const ShoppingListItemDeselected());
    }
  }

  @override
  Widget build(BuildContext context) {
    final formInput = useState<UpdateShoppingListItemInput>(
      UpdateShoppingListItemInput(
        id: selectedShoppingListItem.id,
        label: selectedShoppingListItem.label,
        productId: selectedShoppingListItem.product.id,
        quantity: selectedShoppingListItem.quantity,
        isChecked: selectedShoppingListItem.isChecked,
      ),
    );

    return BlocListener<ShoppingListItemViewModel, ShoppingListItemState>(
      listener: (context, state) {
        if (state.submissionStatus.isSuccess) {
          context.go(
            Uri(path: '${AppRoutes.shoppingLists}/$shoppingListId').toString(),
          );
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 12.0,
        ),
        // height: double.infinity,
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
                  DropdownMenu<ProductOutput>(
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
                formInput,
              ),
              child: Text(
                "Save",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
