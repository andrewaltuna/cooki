part of 'shopping_list_view_model.dart';

class ShoppingListState extends Equatable {
  const ShoppingListState({
    this.status = ViewModelStatus.initial,
    this.updateStatus = ViewModelStatus.initial,
    this.deleteStatus = ViewModelStatus.initial,
    this.itemStatus = ViewModelStatus.initial,
    this.shoppingList = ShoppingList.empty,
    this.error,
  });

  final ViewModelStatus status;
  final ViewModelStatus updateStatus;
  final ViewModelStatus deleteStatus;
  final ViewModelStatus itemStatus;

  final ShoppingList shoppingList;
  final Exception? error;

  ShoppingListState copyWith({
    ViewModelStatus? status,
    ViewModelStatus? updateStatus,
    ViewModelStatus? deleteStatus,
    ViewModelStatus? itemStatus,
    ViewModelStatus? updateItemStatus,
    ViewModelStatus? deleteItemStatus,
    ShoppingList? shoppingList,
    Exception? error,
  }) {
    return ShoppingListState(
      status: status ?? this.status,
      updateStatus: updateStatus ?? this.updateStatus,
      deleteStatus: deleteStatus ?? this.deleteStatus,
      itemStatus: itemStatus ?? this.itemStatus,
      shoppingList: shoppingList ?? this.shoppingList,
      error: error ?? this.error,
    );
  }

  bool get isInitialLoading =>
      status == ViewModelStatus.initial ||
      (status == ViewModelStatus.loading && shoppingList.isEmpty);

  @override
  List<Object?> get props => [
        status,
        updateStatus,
        deleteStatus,
        itemStatus,
        shoppingList,
        error,
      ];
}
