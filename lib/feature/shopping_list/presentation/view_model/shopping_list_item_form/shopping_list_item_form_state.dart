part of 'shopping_list_item_form_view_model.dart';

class ShoppingListItemFormState extends Equatable {
  const ShoppingListItemFormState({
    this.status = ViewModelStatus.initial,
    this.label = '',
    this.productId = '',
    this.quantity = 0,
    this.labelError = '',
    this.quantityError = '',
    this.productIdError = '',
  });

  final ViewModelStatus status;
  final String label;
  final String productId;
  final int quantity;
  final String labelError;
  final String quantityError;
  final String productIdError;

  ShoppingListItemFormState copyWith({
    ViewModelStatus? status,
    String? label,
    String? productId,
    int? quantity,
    String? labelError,
    String? quantityError,
    String? productIdError,
  }) {
    return ShoppingListItemFormState(
      status: status ?? this.status,
      label: label ?? this.label,
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
      labelError: labelError ?? this.labelError,
      quantityError: quantityError ?? this.quantityError,
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
        labelError,
        quantityError,
        productIdError,
      ];
}
