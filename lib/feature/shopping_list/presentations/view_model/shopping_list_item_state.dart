part of 'shopping_list_item_view_model.dart';

class ShoppingListItemState extends Equatable {
  const ShoppingListItemState({
    this.submissionStatus = ViewModelStatus.initial,
    this.status = ViewModelStatus.initial,
    this.item,
    this.error,
  });

  final ViewModelStatus submissionStatus;
  final ViewModelStatus status;
  final ShoppingListItem? item;
  final Exception? error;

  ShoppingListItemState copyWith({
    ViewModelStatus? submissionStatus,
    ViewModelStatus? status,
    ShoppingListItem? item,
    Exception? error,
  }) {
    return ShoppingListItemState(
      submissionStatus: submissionStatus ?? this.submissionStatus,
      status: status ?? this.status,
      item: item ?? this.item,
      error: error ?? this.error,
    );
  }

  bool get isInitialLoading =>
      status == ViewModelStatus.initial ||
      (status == ViewModelStatus.loading && item == null);

  @override
  List<Object?> get props => [
        submissionStatus,
        status,
        item,
        error,
      ];
}
