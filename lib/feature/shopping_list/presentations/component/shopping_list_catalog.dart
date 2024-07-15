import 'package:cooki/common/theme/app_colors.dart';
import 'package:cooki/common/theme/app_text_styles.dart';
import 'package:cooki/feature/shopping_list/data/model/output/shopping_list_output.dart';
import 'package:cooki/feature/shopping_list/presentations/component/shopping_list_delete_modal.dart';
import 'package:cooki/feature/shopping_list/presentations/view_model/shopping_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShoppingListCatalog extends StatelessWidget {
  const ShoppingListCatalog({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShoppingListViewModel, ShoppingListState>(
        builder: (context, state) {
      return SingleChildScrollView(
        child: Column(
          children: [
            for (var list in state.shoppingLists) ShoppingListCard(list: list),
          ],
        ),
      );
    });
  }
}

class ShoppingListCard extends StatelessWidget {
  const ShoppingListCard({
    super.key,
    required this.list,
  });

  final ShoppingListOutput list;

  @override
  Widget build(BuildContext context) {
    return Column(
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
            child: ShoppingListCardContent(list: list),
          ),
        ),
        const SizedBox(
          height: 12,
        ),
      ],
    );
  }
}

class ShoppingListCardContent extends StatelessWidget {
  const ShoppingListCardContent({
    super.key,
    required this.list,
  });

  final ShoppingListOutput list;

  void _onClick(BuildContext context, String shoppingListId) {
    ShoppingListDeleteModal.of(context, shoppingListId)
        .showDeleteShoppingListModal();
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
