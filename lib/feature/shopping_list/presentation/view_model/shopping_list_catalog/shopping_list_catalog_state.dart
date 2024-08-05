part of 'shopping_list_catalog_view_model.dart';

class ShoppingListCatalogState extends Equatable {
  const ShoppingListCatalogState({
    this.status = ViewModelStatus.initial,
    this.submissionStatus = ViewModelStatus.initial,
    this.shoppingLists = const [],
    this.selectedShoppingList,
    this.error,
  });

  final ViewModelStatus status;
  final ViewModelStatus submissionStatus;
  final List<ShoppingList> shoppingLists;
  final ShoppingList? selectedShoppingList;
  final Exception? error;

  ShoppingListCatalogState copyWith({
    ViewModelStatus? status,
    ViewModelStatus? submissionStatus,
    List<ShoppingList>? shoppingLists,
    ShoppingList? selectedShoppingList,
    Exception? error,
  }) {
    return ShoppingListCatalogState(
      status: status ?? this.status,
      submissionStatus: submissionStatus ?? this.submissionStatus,
      shoppingLists: shoppingLists ?? this.shoppingLists,
      selectedShoppingList: selectedShoppingList ?? this.selectedShoppingList,
      error: error ?? this.error,
    );
  }

  bool get isInitialLoading =>
      status == ViewModelStatus.initial ||
      (status == ViewModelStatus.loading && shoppingLists.isEmpty);

  bool get isFetchingShoppingList =>
      status == ViewModelStatus.loading && selectedShoppingList == null;

  bool get isShoppingListDeleted =>
      submissionStatus == ViewModelStatus.success &&
      selectedShoppingList == null;

  ShoppingList shoppingListById(String id) {
    return shoppingLists.firstWhere(
      (list) => list.id == id,
      orElse: () => ShoppingList.empty,
    );
  }

  @override
  List<Object?> get props => [
        status,
        shoppingLists,
        selectedShoppingList,
        error,
      ];
}
