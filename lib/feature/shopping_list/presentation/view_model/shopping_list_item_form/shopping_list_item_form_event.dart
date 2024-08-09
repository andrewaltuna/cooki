part of 'shopping_list_item_form_view_model.dart';

class ShoppingListItemFormEvent extends Equatable {
  const ShoppingListItemFormEvent();

  @override
  List<Object?> get props => [];
}

class ItemFormInitialized extends ShoppingListItemFormEvent {
  const ItemFormInitialized({
    this.section,
    this.productId,
    this.quantity,
  });

  final String? section;
  final String? productId;
  final int? quantity;

  @override
  List<Object?> get props => [
        section,
        productId,
        quantity,
      ];
}

class ItemFormSectionSelected extends ShoppingListItemFormEvent {
  const ItemFormSectionSelected(
    this.section,
  );

  final String section;

  @override
  List<Object> get props => [section];
}

class ItemFormProductSelected extends ShoppingListItemFormEvent {
  const ItemFormProductSelected(
    this.productId,
  );

  final String productId;

  @override
  List<Object> get props => [productId];
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
