import 'package:cooki/common/theme/app_colors.dart';
import 'package:cooki/common/theme/app_text_styles.dart';
import 'package:cooki/feature/product/data/model/product.dart';
import 'package:cooki/feature/shopping_list/data/model/shopping_list_item.dart';
import 'package:cooki/feature/shopping_list/presentation/view_model/shopping_list/shopping_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShoppingListItemAlternativeProducts extends StatelessWidget {
  const ShoppingListItemAlternativeProducts({
    super.key,
    required this.shoppingListItem,
    required this.products,
  });

  final ShoppingListItem shoppingListItem;
  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ShoppingListViewModel, ShoppingListState>(
      listenWhen: (previous, current) =>
          previous.switchItemStatus != current.switchItemStatus,
      listener: (context, state) {
        if (state.switchItemStatus.isSuccess) {
          Navigator.pop(context);
        }
      },
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
          Container(
            height: 300,
            padding: const EdgeInsets.all(12),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Divider(height: 12),
                  for (final product in products) ...[
                    _ProductDetails(
                      shoppingListItem: shoppingListItem,
                      product: product,
                    ),
                    const Divider(height: 12),
                  ],
                ],
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
    required this.shoppingListItem,
  });

  final Product product;
  final ShoppingListItem shoppingListItem;

  void _onPress(
    BuildContext context, {
    required String productId,
    required String itemId,
  }) {
    context.read<ShoppingListViewModel>().add(
          ShoppingListItemSwitched(
            itemId: itemId,
            productId: productId,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.brand,
              style: AppTextStyles.titleSmall,
            ),
            Text(
              'Php ${product.price} / ${product.unitSize}',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.fontTertiary,
              ),
            ),
          ],
        ),
        IconButton(
          onPressed: () => _onPress(
            context,
            productId: product.id,
            itemId: shoppingListItem.id,
          ),
          icon: const Icon(Icons.switch_access_shortcut),
        ),
      ],
    );
  }
}
