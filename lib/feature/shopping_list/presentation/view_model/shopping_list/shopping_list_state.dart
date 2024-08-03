part of 'shopping_list_view_model.dart';

class ShoppingListState extends Equatable {
  const ShoppingListState({
    this.status = ViewModelStatus.initial,
    this.updateStatus = ViewModelStatus.initial,
    this.deleteStatus = ViewModelStatus.initial,
    this.updateItemStatus = ViewModelStatus.initial,
    this.deleteItemStatus = ViewModelStatus.initial,
    this.shoppingList = ShoppingList.empty,
    this.error,
  });

  final ViewModelStatus status;
  final ViewModelStatus updateStatus;
  final ViewModelStatus deleteStatus;
  final ViewModelStatus updateItemStatus;
  final ViewModelStatus deleteItemStatus;

  final ShoppingList shoppingList;
  final Exception? error;

  ShoppingListState copyWith({
    ViewModelStatus? status,
    ViewModelStatus? updateStatus,
    ViewModelStatus? deleteStatus,
    ViewModelStatus? updateItemStatus,
    ViewModelStatus? deleteItemStatus,
    ShoppingList? shoppingList,
    Exception? error,
  }) {
    return ShoppingListState(
      status: status ?? this.status,
      updateStatus: updateStatus ?? this.updateStatus,
      deleteStatus: deleteStatus ?? this.deleteStatus,
      updateItemStatus: updateItemStatus ?? this.updateItemStatus,
      shoppingList: shoppingList ?? this.shoppingList,
      deleteItemStatus: deleteItemStatus ?? this.deleteItemStatus,
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
        updateItemStatus,
        deleteItemStatus,
        shoppingList,
        error,
      ];
}
