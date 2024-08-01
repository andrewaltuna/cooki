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
        // popupmenu item 1
        PopupMenuItem(
          value: 1,
          // row has two child icon and text.
          child: Row(
            children: [
              Icon(Icons.edit),
              SizedBox(
                // sized box with width 10
                width: 10,
              ),
              Text("Edit list information")
            ],
          ),
        ),
        // popupmenu item 2
        PopupMenuItem(
          value: 2,
          // row has two child icon and text
          child: Row(
            children: [
              Icon(Icons.delete),
              SizedBox(
                // sized box with width 10
                width: 10,
              ),
              Text("Delete list")
            ],
          ),
        ),
      ],
      offset: Offset(0, 50),
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
