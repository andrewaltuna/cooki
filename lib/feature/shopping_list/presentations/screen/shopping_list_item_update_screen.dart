import 'package:cooki/common/component/form/custom_form_field.dart';
import 'package:cooki/common/component/main_scaffold.dart';
import 'package:cooki/common/hook/use_on_widget_load.dart';
import 'package:cooki/common/navigation/app_routes.dart';
import 'package:cooki/common/theme/app_text_styles.dart';
import 'package:cooki/feature/product/data/model/output/product_output.dart';
import 'package:cooki/feature/product/presentation/view_model/product_view_model.dart';
import 'package:cooki/feature/shopping_list/data/model/input/update_shopping_list_item_input.dart';
import 'package:cooki/feature/shopping_list/data/model/output/shopping_list_item_output.dart';
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
    // Logic is similar to that of shopping_list_screen, but shoppingListItem doesn't change (always stays null)
    useOnWidgetLoad(() {
      context.read<ShoppingListViewModel>().add(
            ShoppingListItemRequested(
              shoppingListItemId: shoppingListItemId,
            ),
          );
    });

    final (isFetchingShoppingListItem, shoppingListItem) = context.select(
      (ShoppingListViewModel viewModel) => (
        viewModel.state.isFetchingShoppingListItem,
        viewModel.state.selectedShoppingListItem,
      ),
    );

    if (isFetchingShoppingListItem) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (shoppingListItem == null) {
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
    print('Shopping list item ${shoppingListItem}');

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
                        onPressed: () => context.go(
                          Uri(
                            path: '${AppRoutes.shoppingLists}/$shoppingListId',
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
          Expanded(
            child: ShoppingListItemUpdateForm(
              shoppingListId: shoppingListId,
              selectedShoppingListItem: shoppingListItem,
            ),
          ),
        ],
      ),
    );
    // return BlocListener<ShoppingListViewModel, ShoppingListState>(
    //   listener: (context, state) {
    //     // TODO: implement listener
    //     print('Listening...');
    //     print(state.selectedShoppingListItem);
    //   },
    //   child: BlocBuilder<ShoppingListViewModel, ShoppingListState>(
    //     builder: (context, state) {
    //       if (state.isFetchingShoppingListItem) {
    //         return const Center(
    //           child: CircularProgressIndicator(),
    //         );
    //       } else if (state.selectedShoppingListItem == null) {
    //         return Center(
    //           child: Column(
    //             children: [
    //               Text('Not Found'),
    //               TextButton(
    //                 onPressed: () => context.go(
    //                   Uri(
    //                     path: '${AppRoutes.shoppingLists}/$shoppingListId',
    //                   ).toString(),
    //                 ),
    //                 child: Text('Go Back'),
    //               ),
    //             ],
    //           ),
    //         );
    //       }

    //       return BlocListener<ShoppingListViewModel, ShoppingListState>(
    //         listener: (context, state) {
    //           if (state.status.isSuccess) {
    //             context.go(
    //               Uri(
    //                 path: '${AppRoutes.shoppingLists}/$shoppingListId',
    //               ).toString(),
    //             );
    //           }
    //         },
    //         child: MainScaffold(
    //           body: Column(
    //             children: [
    //               Container(
    //                 decoration: BoxDecoration(
    //                   color: Colors.white,
    //                   boxShadow: [
    //                     BoxShadow(
    //                       color: Colors.grey.withOpacity(0.5),
    //                       spreadRadius: 2,
    //                       blurRadius: 7,
    //                       offset: const Offset(0, 3),
    //                     ),
    //                   ],
    //                 ),
    //                 child: Padding(
    //                   padding: const EdgeInsets.symmetric(
    //                     horizontal: 12.0,
    //                     vertical: 16.0,
    //                   ),
    //                   child: Row(
    //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                     children: [
    //                       Row(
    //                         children: [
    //                           IconButton(
    //                             onPressed: () => context.go(
    //                               Uri(
    //                                 path:
    //                                     '${AppRoutes.shoppingLists}/$shoppingListId',
    //                               ).toString(),
    //                             ),
    //                             icon: Icon(
    //                               Icons.arrow_back_sharp,
    //                             ),
    //                           ),
    //                           const SizedBox(
    //                             width: 12.0,
    //                           ),
    //                           Text(
    //                             "Item Details",
    //                             style: AppTextStyles.titleLarge,
    //                           ),
    //                         ],
    //                       ),
    //                       IconButton(
    //                         onPressed: () {},
    //                         icon: Icon(
    //                           Icons.menu,
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //               ),
    //               Expanded(
    //                 child: ShoppingListItemUpdateForm(
    //                   shoppingListId: shoppingListId,
    //                   selectedShoppingListItem: state.selectedShoppingListItem!,
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       );
    //     },
    //   ),
    // );
  }
}

class ShoppingListItemUpdateForm extends HookWidget {
  const ShoppingListItemUpdateForm({
    super.key,
    required this.shoppingListId,
    required this.selectedShoppingListItem,
  });

  final String shoppingListId;
  final ShoppingListItem selectedShoppingListItem;
  static final _formKey = GlobalKey<FormState>();

  void _onSubmit(BuildContext context,
      ValueNotifier<UpdateShoppingListItemInput> formInput) {
    if (_formKey.currentState!.validate()) {
      context.read<ShoppingListViewModel>().add(
            ShoppingListItemUpdated(
              input: formInput.value,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final formInput = useState<UpdateShoppingListItemInput>(
      UpdateShoppingListItemInput(
        id: selectedShoppingListItem.id,
        label: selectedShoppingListItem.label,
        product: selectedShoppingListItem.product,
        quantity: selectedShoppingListItem.quantity,
        isChecked: selectedShoppingListItem.isChecked,
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
                DropdownMenu<ProductOutput>(
                  enableFilter: true,
                  requestFocusOnTap: true,
                  hintText: "Product",
                  onSelected: (value) =>
                      formInput.value = formInput.value.copyWith(
                    product: value,
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
              formInput,
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
