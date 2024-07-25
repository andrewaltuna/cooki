import 'package:cooki/common/component/form/custom_form_field.dart';
import 'package:cooki/common/component/main_scaffold.dart';
import 'package:cooki/common/navigation/app_routes.dart';
import 'package:cooki/common/theme/app_text_styles.dart';
import 'package:cooki/feature/product/data/model/output/product_output.dart';
import 'package:cooki/feature/product/data/model/product.dart';
import 'package:cooki/feature/product/presentation/view_model/product_view_model.dart';
import 'package:cooki/feature/shopping_list/data/di/shopping_list_service_locator.dart';
import 'package:cooki/feature/shopping_list/data/model/input/create_shopping_list_item_input.dart';
import 'package:cooki/feature/shopping_list/data/model/input/shopping_list_item_input.dart';
import 'package:cooki/feature/shopping_list/data/model/input/update_shopping_list_input.dart';
import 'package:cooki/feature/shopping_list/data/model/shopping_list.dart';
import 'package:cooki/feature/shopping_list/presentations/view_model/shopping_list_item_view_model.dart';
import 'package:cooki/feature/shopping_list/presentations/view_model/shopping_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

class ShoppingListItemCreateScreen extends StatelessWidget {
  const ShoppingListItemCreateScreen({
    super.key,
    required this.shoppingListId,
  });

  final String shoppingListId;

  @override
  Widget build(BuildContext context) {
    final (shoppingList) = context.select((ShoppingListViewModel viewModel) =>
        (viewModel.state.selectedShoppingList!));

    return BlocProvider(
      create: (_) => ShoppingListItemViewModel(shoppingListRepository),
      child: BlocListener<ShoppingListViewModel, ShoppingListState>(
        listener: (context, state) {
          if (state.status.isSuccess) {
            context.go(
              Uri(
                path: '${AppRoutes.shoppingLists}/$shoppingListId',
              ).toString(),
            );
          }
        },
        child: MainScaffold(
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
                            onPressed: () => context.go(
                              Uri(
                                path:
                                    '${AppRoutes.shoppingLists}/$shoppingListId',
                              ).toString(),
                            ),
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
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ShoppingListItemCreateForm(
                  shoppingList: shoppingList,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ShoppingListItemCreateForm extends HookWidget {
  const ShoppingListItemCreateForm({
    super.key,
    required this.shoppingList,
  });

  final ShoppingList shoppingList;
  static final _formKey = GlobalKey<FormState>();

  void _onCreate(BuildContext context, UpdateShoppingListInput formInput) {
    if (_formKey.currentState!.validate()) {
      context.read<ShoppingListItemViewModel>().add(
            ShoppingListItemCreated(
              input: formInput,
            ),
          );

      context.go(
        Uri(path: '${AppRoutes.shoppingLists}/${shoppingList.id}').toString(),
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
    final products = context
        .select((ProductViewModel viewModel) => viewModel.state.products);

    return Container(
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
            onPressed: () => _onCreate(
              context,
              UpdateShoppingListInput(id: shoppingList.id, items: [
                ...shoppingList.items.map((item) => item.toInput()),
                formInput.value
              ]),
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
