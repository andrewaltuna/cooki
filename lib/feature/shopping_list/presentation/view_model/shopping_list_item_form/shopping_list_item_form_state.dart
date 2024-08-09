part of 'shopping_list_item_form_view_model.dart';

class ShoppingListItemFormState extends Equatable {
  const ShoppingListItemFormState({
    this.status = ViewModelStatus.initial,
    this.section = '',
    this.productId = '',
    this.quantity = 0,
    this.productIdError = '',
  });

  final ViewModelStatus status;
  final String section;
  final String productId;
  final int quantity;
  final String productIdError;

  ShoppingListItemFormState copyWith({
    ViewModelStatus? status,
    String? label,
    String? section,
    String? productId,
    int? quantity,
    String? productIdError,
  }) {
    return ShoppingListItemFormState(
      status: status ?? this.status,
      section: section ?? this.section,
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
      productIdError: productIdError ?? this.productIdError,
    );
  }

  ShoppingListItemFormOutput toFormOutput() {
    return ShoppingListItemFormOutput(
      productId: productId,
      quantity: quantity,
    );
  }

  @override
  List<Object?> get props => [
        section,
        productId,
        quantity,
        status,
        productIdError,
      ];
}
