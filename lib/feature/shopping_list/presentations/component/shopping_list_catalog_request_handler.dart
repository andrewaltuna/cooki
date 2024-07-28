import 'package:cooki/feature/shopping_list/presentations/view_model/shopping_list_catalog_view_model.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShoppingListCatalogRequestBuilder extends StatelessWidget {
  const ShoppingListCatalogRequestBuilder({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShoppingListCatalogViewModel, ShoppingListCatalogState>(
      builder: (context, state) {
        return child;
      },
    );
  }
}
