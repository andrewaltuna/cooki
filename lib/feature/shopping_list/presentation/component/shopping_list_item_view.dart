import 'package:cooki/feature/product/presentation/component/product_information_view.dart';
import 'package:cooki/feature/shopping_list/presentation/component/shopping_list_item_restrictions.dart';
import 'package:cooki/feature/shopping_list/presentation/view_model/shopping_list/shopping_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShoppingListItemView extends StatelessWidget {
  const ShoppingListItemView({
    required this.itemId,
    super.key,
  });

  final String itemId;

  @override
  Widget build(BuildContext context) {
    final item = context.select(
      (ShoppingListViewModel viewModel) =>
          viewModel.state.shoppingList.itemById(itemId),
    );

    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        clipBehavior: Clip.none,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 16),
            Flexible(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 500),
                child: ProductInformationView(
                  product: item.product,
                  quantity: item.quantity,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Flexible(
              child: ShoppingListItemRestrictions(
                itemId: itemId,
                productId: item.product.id,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
