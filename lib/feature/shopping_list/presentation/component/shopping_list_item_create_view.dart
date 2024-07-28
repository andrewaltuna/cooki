import 'package:cooki/common/component/form/custom_form_field.dart';
import 'package:cooki/common/component/main_scaffold.dart';
import 'package:cooki/common/navigation/app_routes.dart';
import 'package:cooki/common/screen/error_screen.dart';
import 'package:cooki/common/screen/loading_screen.dart';
import 'package:cooki/common/theme/app_text_styles.dart';
import 'package:cooki/feature/product/data/model/product.dart';
import 'package:cooki/feature/product/presentation/view_model/product_view_model.dart';
import 'package:cooki/feature/shopping_list/data/model/input/create_shopping_list_item_input.dart';
import 'package:cooki/feature/shopping_list/data/model/input/shopping_list_item_input.dart';
import 'package:cooki/feature/shopping_list/presentation/view_model/shopping_list_catalog_view_model.dart';
import 'package:cooki/feature/shopping_list/presentation/view_model/shopping_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

class ShoppingListItemCreateView extends StatelessWidget {
  const ShoppingListItemCreateView({
    super.key,
    required this.shoppingListId,
  });

  final String shoppingListId;

  @override
  Widget build(BuildContext context) {
    final (status) = context.select(
      (ShoppingListViewModel viewModel) => (viewModel.state.status),
    );

    if (status.isLoading) {
      return const LoadingScreen();
    } else if (status.isError) {
      return const ErrorScreen(
        errorMessage: 'Not found',
        path: AppRoutes.shoppingLists,
      );
    }

    return BlocConsumer<ShoppingListViewModel, ShoppingListState>(
      listener: (context, state) {
        context.read<ShoppingListCatalogViewModel>().add(
              ShoppingListEntryUpdated(
                updatedShoppingList: state.shoppingList!,
              ),
            );

        if (state.createItemStatus.isSuccess) {
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        return MainScaffold(
          title: "Create Item",
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
          body: _ItemCreateForm(
            shoppingListId: shoppingListId,
          ),
        );
      },
    );
  }
}

// TODO: Make own component to be used by update/create
class _ItemCreateForm extends HookWidget {
  const _ItemCreateForm({
    super.key,
    required this.shoppingListId,
  });

  final String shoppingListId;
  static final _formKey = GlobalKey<FormState>();

  void _onSubmit(
    BuildContext context,
    String shoppingListId,
    ShoppingListItemInput formInput,
  ) {
    if (_formKey.currentState!.validate()) {
      final input = CreateShoppingListItemInput(
        shoppingListId: shoppingListId,
        label: formInput.label,
        productId: formInput.productId,
        quantity: formInput.quantity,
      );

      context.read<ShoppingListViewModel>().add(
            ShoppingListItemCreated(
              input: input,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final formInput = useState<ShoppingListItemInput>(
      const ShoppingListItemInput(
        label: '',
        productId: '',
        quantity: 0,
      ),
    );

    final products = context.read<ProductViewModel>().state.products;

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
              shoppingListId,
              formInput.value,
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
