part of 'shopping_list_item_form_view_model.dart';

class ShoppingListItemFormState extends Equatable {
  const ShoppingListItemFormState({
    this.status = ViewModelStatus.initial,
    this.label = '',
    this.productId = '',
    this.quantity = 0,
    this.productIdError = '',
  });

  final ViewModelStatus status;
  final String label;
  final String productId;
  final int quantity;
  final String productIdError;

  ShoppingListItemFormState copyWith({
    ViewModelStatus? status,
    String? label,
    String? productId,
    int? quantity,
    String? productIdError,
  }) {
    return ShoppingListItemFormState(
      status: status ?? this.status,
      label: label ?? this.label,
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
      productIdError: productIdError ?? this.productIdError,
    );
  }

  ShoppingListItemFormOutput toFormOutput() {
    return ShoppingListItemFormOutput(
      label: label,
      productId: productId,
      quantity: quantity,
    );
  }

  @override
  List<Object?> get props => [
        label,
        productId,
        quantity,
        status,
        productIdError,
      ];
}
