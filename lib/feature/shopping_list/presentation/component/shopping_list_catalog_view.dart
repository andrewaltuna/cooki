import 'package:cooki/common/component/button/primary_button.dart';
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
    return BlocBuilder<ShoppingListCatalogViewModel, ShoppingListCatalogState>(
      builder: (context, state) {
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

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(height: 16),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      for (var list in shoppingLists)
                        _ShoppingListCard(
                          shoppingList: list,
                        ),
                    ],
                  ),
                ),
              ),
              PrimaryButton(
                label: 'Create List',
                onPress: () => _onSubmitted(context),
              ),
            ],
          ),
        );
      },
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
    return TextButton(
      style: ButtonStyle(
        overlayColor: WidgetStateProperty.all(
          Colors.transparent,
        ),
        padding: WidgetStateProperty.all(
          EdgeInsets.zero,
        ),
      ),
      onPressed: () => context.go(
        '${AppRoutes.shoppingLists}/${shoppingList.id}',
      ),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: AppColors.accent,
            ),
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 24.0,
                horizontal: 16.0,
              ),
              child: _ShoppingListInformation(shoppingList: shoppingList),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
        ],
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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          shoppingList.name,
          style: AppTextStyles.titleMedium.copyWith(
            color: Colors.white,
          ),
        ),
        Text(
          '${shoppingList.items.length} items',
          style: AppTextStyles.bodyMedium.copyWith(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
