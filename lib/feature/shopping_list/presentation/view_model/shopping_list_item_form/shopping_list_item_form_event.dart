part of 'shopping_list_item_form_view_model.dart';

class ShoppingListItemFormEvent extends Equatable {
  const ShoppingListItemFormEvent();

  @override
  List<Object?> get props => [];
}

class ItemFormInitialized extends ShoppingListItemFormEvent {
  const ItemFormInitialized([
    this.label,
    this.productId,
    this.quantity,
  ]);

  final String? label;
  final String? productId;
  final int? quantity;

  @override
  List<Object?> get props => [
        label,
        productId,
        quantity,
      ];
}

class ItemFormProductSelected extends ShoppingListItemFormEvent {
  const ItemFormProductSelected(
    this.productId,
  );

  final String productId;

  @override
  List<Object> get props => [productId];
}

class ItemFormLabelChanged extends ShoppingListItemFormEvent {
  const ItemFormLabelChanged(
    this.label,
  );

  final String label;

  @override
  List<Object> get props => [label];
}

class ItemFormQuantityChanged extends ShoppingListItemFormEvent {
  const ItemFormQuantityChanged(
    this.quantity,
  );

  final int quantity;

  @override
  List<Object> get props => [quantity];
}

class ItemFormProductIdErrorChanged extends ShoppingListItemFormEvent {
  const ItemFormProductIdErrorChanged([
    this.productIdError = '',
  ]);

  final String productIdError;

  @override
  List<Object> get props => [productIdError];
}
