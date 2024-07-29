part of 'shopping_list_view_model.dart';

class ShoppingListState extends Equatable {
  const ShoppingListState({
    this.status = ViewModelStatus.initial,
    this.updateStatus = ViewModelStatus.initial,
    this.deleteStatus = ViewModelStatus.initial,
    this.createItemStatus = ViewModelStatus.initial,
    this.updateItemStatus = ViewModelStatus.initial,
    this.deleteItemStatus = ViewModelStatus.initial,
    this.shoppingList,
    this.error,
  });

  final ViewModelStatus status;
  final ViewModelStatus updateStatus;
  final ViewModelStatus deleteStatus;
  final ViewModelStatus createItemStatus;
  final ViewModelStatus updateItemStatus;
  final ViewModelStatus deleteItemStatus;
  final ShoppingList? shoppingList;
  final Exception? error;

  ShoppingListState copyWith({
    ViewModelStatus? status,
    ViewModelStatus? updateStatus,
    ViewModelStatus? deleteStatus,
    ViewModelStatus? createItemStatus,
    ViewModelStatus? updateItemStatus,
    ViewModelStatus? deleteItemStatus,
    ShoppingList? shoppingList,
    Exception? error,
  }) {
    return ShoppingListState(
      status: status ?? this.status,
      updateStatus: updateStatus ?? this.updateStatus,
      deleteStatus: deleteStatus ?? this.deleteStatus,
      createItemStatus: createItemStatus ?? this.createItemStatus,
      updateItemStatus: updateItemStatus ?? this.updateItemStatus,
      deleteItemStatus: deleteItemStatus ?? this.deleteItemStatus,
      shoppingList: shoppingList ?? this.shoppingList,
      error: error ?? this.error,
    );
  }

  bool get isInitialLoading =>
      status == ViewModelStatus.initial ||
      (status == ViewModelStatus.loading && shoppingList == null);

  @override
  List<Object?> get props => [
        status,
        updateStatus,
        deleteStatus,
        createItemStatus,
        updateItemStatus,
        deleteItemStatus,
        shoppingList,
        error,
      ];
}
