import 'package:cooki/common/theme/app_colors.dart';
import 'package:cooki/feature/shopping_list/data/model/shopping_list.dart';
import 'package:cooki/feature/shopping_list/presentation/component/shopping_list_helper.dart';
import 'package:flutter/material.dart';

class ShoppingListPopupMenu extends StatelessWidget {
  const ShoppingListPopupMenu({
    super.key,
    required this.parentContext,
    required this.shoppingList,
  });

  final BuildContext parentContext;
  final ShoppingList shoppingList;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: 1,
          child: Row(
            children: [
              Icon(Icons.edit),
              SizedBox(
                width: 10,
              ),
              Text('Edit information'),
            ],
          ),
        ),
        const PopupMenuItem(
          value: 2,
          child: Row(
            children: [
              Icon(Icons.delete),
              SizedBox(
                width: 10,
              ),
              Text('Delete list'),
            ],
          ),
        ),
      ],
      offset: const Offset(0, 50),
      color: AppColors.backgroundPrimary,
      elevation: 2,
      onSelected: (value) {
        if (value == 1) {
          ShoppingListHelper.of(parentContext).showUpdateModal();
        } else if (value == 2) {
          ShoppingListHelper.of(parentContext).showDeleteModal(shoppingList.id);
        }
      },
    );
  }
}
