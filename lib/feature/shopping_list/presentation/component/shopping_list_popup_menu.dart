import 'package:cooki/common/theme/app_colors.dart';
import 'package:cooki/common/theme/app_text_styles.dart';
import 'package:cooki/feature/shopping_list/data/model/shopping_list.dart';
import 'package:cooki/feature/shopping_list/presentation/component/shopping_list_helper.dart';
import 'package:flutter/material.dart';

class ShoppingListPopupMenu extends StatelessWidget {
  const ShoppingListPopupMenu({
    required this.shoppingList,
    super.key,
  });

  final ShoppingList shoppingList;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: 1,
          child: _PopupMenuItem(
            icon: Icons.edit,
            text: 'Edit',
          ),
        ),
        const PopupMenuItem(
          value: 2,
          child: _PopupMenuItem(
            icon: Icons.delete,
            text: 'Delete',
          ),
        ),
      ],
      offset: const Offset(0, 50),
      color: AppColors.backgroundPrimary,
      iconColor: AppColors.fontPrimary,
      elevation: 2,
      onSelected: (value) {
        if (value == 1) {
          ShoppingListHelper.of(context).showUpdateDialog();
        } else if (value == 2) {
          ShoppingListHelper.of(context).showDeleteDialog(shoppingList.id);
        }
      },
    );
  }
}

class _PopupMenuItem extends StatelessWidget {
  const _PopupMenuItem({
    required this.icon,
    required this.text,
  });

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon),
        const SizedBox(width: 10),
        Text(
          text,
          style: AppTextStyles.bodySmall,
        ),
      ],
    );
  }
}
