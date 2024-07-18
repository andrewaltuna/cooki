import 'package:cooki/common/hook/use_on_widget_load.dart';
import 'package:cooki/common/navigation/app_routes.dart';
import 'package:cooki/common/theme/app_colors.dart';
import 'package:cooki/common/theme/app_text_styles.dart';
import 'package:cooki/feature/shopping_list/data/model/output/shopping_list_output.dart';
import 'package:cooki/feature/shopping_list/presentations/component/shopping_list_helper.dart';
import 'package:cooki/feature/shopping_list/presentations/view_model/shopping_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ShoppingListCatalog extends StatelessWidget {
  const ShoppingListCatalog({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShoppingListViewModel, ShoppingListState>(
        builder: (context, state) {
      return SingleChildScrollView(
        child: Column(
          children: [
            for (var list in state.shoppingLists) _ShoppingListCard(list: list),
          ],
        ),
      );
    });
  }
}

class _ShoppingListCard extends StatelessWidget {
  const _ShoppingListCard({
    required this.list,
  });

  final ShoppingListOutput list;

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
      onPressed: () => {
        context.go(
          Uri(
            path: '${AppRoutes.shoppingLists}/${list.id}',
          ).toString(),
        ),
      },
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
              child: _ShoppingListCardContent(list: list),
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

class _ShoppingListCardContent extends StatelessWidget {
  const _ShoppingListCardContent({
    super.key,
    required this.list,
  });

  final ShoppingListOutput list;

  void _onClick(BuildContext context, String shoppingListId) {
    ShoppingListHelper.of(context).showDeleteShoppingListModal(shoppingListId);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () => _onClick(
                context,
                list.id,
              ),
              icon: const Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              list.name,
              style: AppTextStyles.titleMedium.copyWith(
                color: Colors.white,
              ),
            ),
          ],
        ),
        Text(
          '${list.items.length.toString()} items',
          style: AppTextStyles.bodyMedium.copyWith(
            color: Colors.white,
          ),
        )
      ],
    );
  }
}
