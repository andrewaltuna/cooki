import 'package:cooki/feature/shopping_list/data/di/shopping_list_service_locator.dart';
import 'package:cooki/feature/shopping_list/presentations/view_model/shopping_list_catalog_view_model.dart';
import 'package:cooki/feature/shopping_list/presentations/view_model/shopping_list_view_model.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShoppingListBloc extends StatelessWidget {
  const ShoppingListBloc({
    super.key,
    required this.shoppingListId,
    required this.child,
  });

  final String shoppingListId;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    print('[ShoppingListBloc] $shoppingListId');
    print(
        '[ShoppingListBloc] state: ${context.read<ShoppingListCatalogViewModel>().state.shoppingLists}');
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
      child: child,
    );
  }
}
