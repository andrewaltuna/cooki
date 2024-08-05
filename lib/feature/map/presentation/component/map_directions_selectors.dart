import 'package:cooki/common/component/button/custom_icon_button.dart';
import 'package:cooki/common/component/dropdown/custom_dropdown_menu.dart';
import 'package:cooki/common/theme/app_colors.dart';
import 'package:cooki/feature/map/presentation/view_model/map_view_model.dart';
import 'package:cooki/feature/product/data/model/product.dart';
import 'package:cooki/feature/product/presentation/view_model/product_view_model.dart';
import 'package:cooki/feature/shopping_list/data/model/shopping_list.dart';
import 'package:cooki/feature/shopping_list/presentation/view_model/shopping_list_catalog/shopping_list_catalog_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class MapDirectionsSelectors extends HookWidget {
  const MapDirectionsSelectors({super.key});

  void _onCleared(
    BuildContext context, {
    required TextEditingController shoppingListController,
    required TextEditingController productController,
  }) {
    context.read<MapViewModel>()
      ..add(const MapShoppingListSet())
      ..add(const MapProductSet());

    shoppingListController.clear();
    productController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final (
      selectedShoppingListId,
      selectedProductId,
    ) = context.select(
      (MapViewModel viewModel) => (
        viewModel.state.selectedShoppingListId,
        viewModel.state.selectedProductId,
      ),
    );

    final (
      shoppingLists,
      selectedShoppingList,
    ) = context.select(
      (ShoppingListCatalogViewModel viewModel) => (
        viewModel.state.shoppingLists,
        viewModel.state.shoppingListById(selectedShoppingListId),
      ),
    );

    final selectedProduct = context.select(
      (ProductViewModel viewModel) => viewModel.state.productById(
        selectedProductId,
      ),
    );

    final shoppingListController = useTextEditingController(
      text: selectedShoppingList.name,
    );
    final productController = useTextEditingController(
      text: selectedProduct.brand,
    );

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _ShoppingListSelector(
            controller: shoppingListController,
            shoppingLists: shoppingLists,
          ),
          if (selectedShoppingList.isNotEmpty) ...[
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: _ProductSelector(
                    controller: productController,
                    products: selectedShoppingList.items
                        .map((item) => item.product)
                        .toList(),
                  ),
                ),
                const SizedBox(width: 8),
                _ClearButton(
                  onCleared: () => _onCleared(
                    context,
                    shoppingListController: shoppingListController,
                    productController: productController,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _ShoppingListSelector extends StatelessWidget {
  const _ShoppingListSelector({
    required this.controller,
    required this.shoppingLists,
  });

  final TextEditingController controller;
  final List<ShoppingList> shoppingLists;

  void _onSelected(
    BuildContext context,
    String? value,
  ) {
    context.read<MapViewModel>().add(MapShoppingListSet(value ?? ''));

    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return CustomDropdownMenu(
      controller: controller,
      icon: const Icon(Icons.shopping_cart),
      hintText: 'Select shopping list',
      fillColor: AppColors.backgroundTextField,
      onSelected: (value) => _onSelected(context, value),
      entries: shoppingLists
          .map(
            (shoppingList) => CustomDropdownMenuEntry(
              value: shoppingList.id,
              label: shoppingList.name,
            ),
          )
          .toList(),
    );
  }
}

class _ProductSelector extends StatelessWidget {
  const _ProductSelector({
    required this.controller,
    required this.products,
  });

  final TextEditingController controller;
  final List<Product> products;

  void _onSelected(
    BuildContext context,
    String? value,
  ) {
    context.read<MapViewModel>().add(MapProductSet(value ?? ''));

    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return CustomDropdownMenu(
      controller: controller,
      icon: const Icon(Icons.label),
      hintText: 'Select product',
      fillColor: AppColors.backgroundTextField,
      onSelected: (value) => _onSelected(context, value),
      entries: products
          .map(
            (product) => CustomDropdownMenuEntry(
              value: product.id,
              label: product.brand,
            ),
          )
          .toList(),
    );
  }
}

class _ClearButton extends StatelessWidget {
  const _ClearButton({
    required this.onCleared,
  });

  final VoidCallback onCleared;

  @override
  Widget build(BuildContext context) {
    return CustomIconButton(
      size: 40,
      iconSize: 20,
      padding: 0,
      icon: Icons.clear,
      color: AppColors.fontPrimary,
      backgroundColor: AppColors.backgroundSecondary,
      onPressed: onCleared,
    );
  }
}
