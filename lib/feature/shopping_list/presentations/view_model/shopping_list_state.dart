part of 'shopping_list_view_model.dart';

class ShoppingListState extends Equatable {
  const ShoppingListState({
    this.status = ViewModelStatus.initial,
    this.shoppingLists = const [],
    this.selectedShoppingListId,
    this.error,
  });

  final ViewModelStatus status;
  final List<ShoppingListOutput> shoppingLists;
  final String? selectedShoppingListId;
  final Exception? error;

  ShoppingListState copyWith({
    ViewModelStatus? status,
    List<ShoppingListOutput>? shoppingLists,
    String? selectedShoppingListId,
    Exception? error,
  }) {
    return ShoppingListState(
      status: status ?? this.status,
      shoppingLists: shoppingLists ?? this.shoppingLists,
      selectedShoppingListId:
          selectedShoppingListId ?? this.selectedShoppingListId,
      error: error ?? this.error,
    );
  }

  bool get isInitialLoading =>
      status == ViewModelStatus.initial ||
      (status == ViewModelStatus.loading && shoppingLists.isEmpty);

  @override
  List<Object?> get props => [
        status,
        shoppingLists,
        selectedShoppingListId,
        error,
      ];
}
