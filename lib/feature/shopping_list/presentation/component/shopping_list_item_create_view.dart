import 'package:cooki/common/component/main_scaffold.dart';
import 'package:cooki/common/navigation/app_routes.dart';
import 'package:cooki/common/screen/error_screen.dart';
import 'package:cooki/common/screen/loading_screen.dart';
import 'package:cooki/feature/shopping_list/data/model/input/create_shopping_list_item_input.dart';
import 'package:cooki/feature/shopping_list/data/model/input/shopping_list_item_input.dart';
import 'package:cooki/feature/shopping_list/presentation/component/shopping_list_item_form.dart';
import 'package:cooki/feature/shopping_list/presentation/view_model/shopping_list_catalog_view_model.dart';
import 'package:cooki/feature/shopping_list/presentation/view_model/shopping_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ShoppingListItemCreateView extends StatelessWidget {
  const ShoppingListItemCreateView({
    super.key,
    required this.shoppingListId,
  });

  final String shoppingListId;

  void _onItemCreate(
    BuildContext context,
    ShoppingListItemInput formInput,
    String shoppingListId,
  ) {
    final input = CreateShoppingListItemInput(
      shoppingListId: shoppingListId,
      label: formInput.label,
      productId: formInput.productId,
      quantity: formInput.quantity,
    );

    context.read<ShoppingListViewModel>().add(
          ShoppingListItemCreated(
            input: input,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final (status) = context.select(
      (ShoppingListViewModel viewModel) => (viewModel.state.status),
    );

    if (status.isLoading) {
      return const LoadingScreen();
    } else if (status.isError) {
      return const ErrorScreen(
        errorMessage: 'Not found',
        path: AppRoutes.shoppingLists,
      );
    }

    const formInput = ShoppingListItemInput(
      label: '',
      productId: '',
      quantity: 0,
    );

    return BlocConsumer<ShoppingListViewModel, ShoppingListState>(
      listener: (context, state) {
        context.read<ShoppingListCatalogViewModel>().add(
              ShoppingListEntryUpdated(
                updatedShoppingList: state.shoppingList!,
              ),
            );

        if (state.createItemStatus.isSuccess) {
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        return MainScaffold(
          title: "Create Item",
          leading: IconButton(
            onPressed: () {
              context.go(
                '${AppRoutes.shoppingLists}/$shoppingListId',
              );
            },
            icon: const Icon(
              Icons.arrow_back,
            ),
          ),
          body: ShoppingListItemForm(
            initialValue: formInput,
            onSubmit: (formValues) => _onItemCreate(
              context,
              formValues,
              shoppingListId,
            ),
          ),
        );
      },
    );
  }
}
