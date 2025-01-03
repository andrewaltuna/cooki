import 'package:collection/collection.dart';
import 'package:cooki/common/component/button/ink_well_button.dart';
import 'package:cooki/common/theme/app_colors.dart';
import 'package:cooki/common/theme/app_text_styles.dart';
import 'package:cooki/feature/product/data/model/product.dart';
import 'package:cooki/feature/product/presentation/component/product_information_collapsed_view.dart';
import 'package:cooki/feature/shopping_list/presentation/component/shopping_list_helper.dart';
import 'package:cooki/feature/shopping_list/presentation/view_model/interfered_restrictions/interfered_restrictions_view_model.dart';
import 'package:cooki/feature/shopping_list/presentation/view_model/shopping_list/shopping_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShoppingListItemAlternativeProducts extends StatelessWidget {
  const ShoppingListItemAlternativeProducts({
    super.key,
    required this.itemId,
    required this.products,
  });

  final String itemId;
  final List<Product> products;

  void _listener(BuildContext context, ShoppingListState state) {
    if (state.switchItemStatus.isSuccess) {
      final updatedItem = state.shoppingList.itemById(itemId);

      context.read<InterferedRestrictionsViewModel>().add(
            InterferedRestrictionsRequested(
              updatedItem.product.id,
            ),
          );

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ShoppingListViewModel, ShoppingListState>(
      listenWhen: (previous, current) =>
          previous.switchItemStatus != current.switchItemStatus,
      listener: _listener,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.maxFinite,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              color: AppColors.accent,
            ),
            child: const Padding(
              padding: EdgeInsets.all(16.0),
              child: _ModalHeader(),
            ),
          ),
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(12),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: products.mapIndexed(
                    (index, product) {
                      final isLastItem = index == products.length - 1;

                      return Column(
                        children: [
                          _ProductDetails(
                            shoppingListItemId: itemId,
                            product: product,
                          ),
                          if (!isLastItem) const Divider(height: 12),
                        ],
                      );
                    },
                  ).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ModalHeader extends StatelessWidget {
  const _ModalHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Alternatives',
          style: AppTextStyles.titleMedium.copyWith(
            color: AppColors.fontSecondary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Consider switching this product with one of the following alternatives:',
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.fontSecondary,
          ),
        ),
      ],
    );
  }
}

class _ProductDetails extends StatelessWidget {
  const _ProductDetails({
    required this.product,
    required this.shoppingListItemId,
  });

  final Product product;
  final String shoppingListItemId;

  void _onPress(BuildContext context) {
    context.read<ShoppingListViewModel>().add(
          ShoppingListItemSwitched(
            itemId: shoppingListItemId,
            productId: product.id,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return InkWellButton(
      backgroundColor: Colors.transparent,
      onPressed: () =>
          ShoppingListHelper.of(context).showProductInformationDialog(
        product,
      ),
      child: Row(
        children: [
          Expanded(
            child: ProductInformationCollapsedView(
              product: product,
            ),
          ),
          IconButton(
            onPressed: () => _onPress(context),
            icon: const Icon(Icons.switch_access_shortcut),
          ),
        ],
      ),
    );
  }
}
