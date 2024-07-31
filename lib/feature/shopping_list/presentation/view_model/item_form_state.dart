part of 'item_form_view_model.dart';

class ItemFormState extends Equatable {
  const ItemFormState({
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

  ItemFormState copyWith({
    ViewModelStatus? status,
    String? label,
    String? productId,
    int? quantity,
    String? labelError,
    String? quantityError,
    String? productIdError,
  }) {
    return ItemFormState(
      status: status ?? this.status,
      label: label ?? this.label,
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
      labelError: labelError ?? this.labelError,
      quantityError: quantityError ?? this.quantityError,
      productIdError: productIdError ?? this.productIdError,
    );
  }

  ShoppingListItemInput toFormOutput() {
    return ShoppingListItemInput(
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
