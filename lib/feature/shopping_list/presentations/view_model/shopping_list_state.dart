part of 'shopping_list_view_model.dart';


class ShoppingListState extends Equatable {
  const ShoppingListState({
    this.status = ViewModelStatus.initial,
    this.shoppingLists = const [],
    this.error
  });

  final ViewModelStatus status;
  final List<ShoppingListOutput> shoppingLists;
  final Exception? error;

  ShoppingListState copyWith({
    ViewModelStatus? status,
    List<ShoppingListOutput>? shoppingLists,
    Exception? error
  }) {
    return ShoppingListState(
      status: status ?? this.status,
      shoppingLists: shoppingLists ?? this.shoppingLists,
      error: error ?? this.error
    );
  }

  bool get isInitialLoading => status ==  ViewModelStatus.initial || (
    status == ViewModelStatus.loading && shoppingLists.isEmpty
  );

  @override
  List<Object> get props => [
    shoppingLists,];
}