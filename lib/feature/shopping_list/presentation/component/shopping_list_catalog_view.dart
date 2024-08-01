import 'package:collection/collection.dart';
import 'package:cooki/common/component/button/custom_icon_button.dart';
import 'package:cooki/common/component/button/ink_well_button.dart';
import 'package:cooki/common/navigation/app_routes.dart';
import 'package:cooki/common/screen/error_screen.dart';
import 'package:cooki/common/screen/loading_screen.dart';
import 'package:cooki/common/theme/app_colors.dart';
import 'package:cooki/common/theme/app_text_styles.dart';
import 'package:cooki/feature/shopping_list/data/model/shopping_list.dart';
import 'package:cooki/feature/shopping_list/presentation/component/shopping_list_helper.dart';
import 'package:cooki/feature/shopping_list/presentation/view_model/shopping_list_catalog_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ShoppingListCatalogView extends StatelessWidget {
  const ShoppingListCatalogView({super.key});

  void _onSubmitted(BuildContext context) {
    ShoppingListHelper.of(context).showCreateShoppingListModal();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ShoppingListCatalogViewModel>().state;

    final status = state.status;
    final shoppingLists = state.shoppingLists;

    if (status.isLoading) {
      return const LoadingScreen();
    }

    if (status.isError) {
      return const ErrorScreen(
        errorMessage: 'Something went wrong.',
      );
    }

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            children: shoppingLists.mapIndexed(
              (index, shoppingList) {
                final isLast = index == shoppingLists.length - 1;

                return Padding(
                  padding: EdgeInsets.only(
                    top: 16,
                    bottom: isLast ? 16 : 0,
                  ),
                  child: _ShoppingListCard(
                    shoppingList: shoppingList,
                  ),
                );
              },
            ).toList(),
          ),
        ),
        Positioned(
          bottom: 16,
          right: 16,
          child: CustomIconButton(
            icon: Icons.add,
            onPressed: () => _onSubmitted(context),
          ),
        ),
      ],
    );
  }
}

class _ShoppingListCard extends StatelessWidget {
  const _ShoppingListCard({
    required this.shoppingList,
  });

  final ShoppingList shoppingList;

  @override
  Widget build(BuildContext context) {
    return InkWellButton(
      onPressed: () => context.go(
        '${AppRoutes.shoppingLists}/${shoppingList.id}',
      ),
      backgroundColor: AppColors.backgroundSecondary,
      circularBorderRadius: 8,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 24.0,
          horizontal: 16.0,
        ),
        child: _ShoppingListInformation(
          shoppingList: shoppingList,
        ),
      ),
    );
  }
}

class _ShoppingListInformation extends StatelessWidget {
  const _ShoppingListInformation({
    required this.shoppingList,
  });

  final ShoppingList shoppingList;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            shoppingList.name,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.titleSmall,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          '${shoppingList.items.length} items',
          style: AppTextStyles.bodySmall,
        ),
      ],
    );
  }
}
