import 'package:cooki/feature/shopping_list/presentations/view_model/shopping_list_view_model.dart';
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
                  Text(list.name),
                  Text(list.budget.toString()),
                ],
              ),
          ],
        ),
      );
    });
  }
}
