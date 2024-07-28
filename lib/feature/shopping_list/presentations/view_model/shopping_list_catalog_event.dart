part of 'shopping_list_catalog_view_model.dart';

sealed class ShoppingListCatalogEvent extends Equatable {
  const ShoppingListCatalogEvent();

  @override
  List<Object?> get props => [];
}

class ShoppingListCatalogRequested extends ShoppingListCatalogEvent {
  const ShoppingListCatalogRequested();
}

class ShoppingListCreated extends ShoppingListCatalogEvent {
  const ShoppingListCreated({
    required this.name,
    required this.budget,
  });

  final String name;
  final String budget;

  @override
  List<Object?> get props => [
        name,
        budget,
      ];
}

class ShoppingListEntryUpdated extends ShoppingListCatalogEvent {
  const ShoppingListEntryUpdated({
    required this.updatedShoppingList,
  });

  final ShoppingList updatedShoppingList;

  @override
  List<Object?> get props => [
        updatedShoppingList,
      ];
}

// TODO: Remove
// class ShoppingListSelected extends ShoppingListCatalogEvent {
//   const ShoppingListSelected(this.id);

//   final String id;

//   @override
//   List<Object?> get props => [
//         id,
//       ];
// }

// class ShoppingListDeleted extends ShoppingListCatalogEvent {
//   const ShoppingListDeleted({
//     required this.id,
//   });

//   final String id;

//   @override
//   List<Object?> get props => [id];
// }

// class ShoppingListItemToggled extends ShoppingListCatalogEvent {
//   const ShoppingListItemToggled({
//     required this.input,
//   });

//   final UpdateShoppingListItemInput input;

//   @override
//   List<Object?> get props => [
//         input,
//       ];
// }
