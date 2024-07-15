import 'package:cooki/common/theme/app_colors.dart';
import 'package:cooki/common/theme/app_text_styles.dart';
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
            for (var list in state.shoppingLists)
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: AppColors.accent,
                    ),
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 24.0, horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                onPressed: () =>
                                    context.read<ShoppingListViewModel>().add(
                                          ShoppingListDeleted(list.id),
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
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                ],
              ),
          ],
        ),
      );
    });
  }
}
