import 'package:cooki/common/navigation/app_routes.dart';
import 'package:cooki/feature/shopping_list/data/di/shopping_list_service_locator.dart';
import 'package:cooki/feature/shopping_list/presentations/view_model/shopping_list_catalog_view_model.dart';
import 'package:cooki/feature/shopping_list/presentations/view_model/shopping_list_view_model.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ShoppingListRequestHandler extends StatelessWidget {
  const ShoppingListRequestHandler({
    super.key,
    required this.shoppingListId,
    required this.child,
  });

  final String shoppingListId;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final shoppingList = context
        .read<ShoppingListCatalogViewModel>()
        .state
        .shoppingLists
        .firstWhere(
          (list) => list.id == shoppingListId,
        );

    return BlocProvider(
      create: (_) => ShoppingListViewModel(shoppingListRepository)
        ..add(
          ShoppingListRequested(
            shoppingList: shoppingList,
          ),
        ),
      child: BlocConsumer<ShoppingListViewModel, ShoppingListState>(
        listenWhen: (previous, current) =>
            previous.shoppingList != current.shoppingList ||
            previous.updateStatus != current.updateStatus,
        // previous.deleteStatus != current.deleteStatus ||
        // previous.createItemStatus != current.createItemStatus ||
        // previous.updateItemStatus != current.updateItemStatus ||
        // previous.deleteItemStatus != current.deleteItemStatus,
        listener: (context, state) {
          context.read<ShoppingListCatalogViewModel>().add(
                ShoppingListEntryUpdated(
                  updatedShoppingList: state.shoppingList!,
                ),
              );

          if (state.deleteStatus.isSuccess) {
            context.go(AppRoutes.shoppingLists);
          } else if (state.createItemStatus.isSuccess ||
              state.updateItemStatus.isSuccess ||
              state.deleteItemStatus.isSuccess) {
            context.go('${AppRoutes.shoppingLists}/$shoppingListId');
          }
        },
        // buildWhen: (previous, current) =>
        //     previous.shoppingList != current.shoppingList,
        builder: (context, state) {
          return child;
        },
      ),
    );
  }
}
