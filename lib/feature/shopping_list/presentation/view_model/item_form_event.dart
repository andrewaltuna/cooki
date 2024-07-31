part of 'item_form_view_model.dart';

class ItemFormEvent extends Equatable {
  const ItemFormEvent();

  @override
  List<Object?> get props => [];
}

class ItemFormInitialized extends ItemFormEvent {
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

class ItemFormProductSelected extends ItemFormEvent {
  const ItemFormProductSelected(
    this.productId,
  );

  final String productId;

  @override
  List<Object> get props => [productId];
}

class ItemFormLabelChanged extends ItemFormEvent {
  const ItemFormLabelChanged(
    this.label,
  );

  final String label;

  @override
  List<Object> get props => [label];
}

class ItemFormQuantityChanged extends ItemFormEvent {
  const ItemFormQuantityChanged(
    this.quantity,
  );

  final int quantity;

  @override
  List<Object> get props => [quantity];
}

class ItemFormLabelErrorChanged extends ItemFormEvent {
  const ItemFormLabelErrorChanged([
    this.labelError = '',
  ]);

  final String labelError;

  @override
  List<Object> get props => [labelError];
}

class ItemFormQuantityErrorChanged extends ItemFormEvent {
  const ItemFormQuantityErrorChanged([
    this.quantityError = '',
  ]);

  final String quantityError;

  @override
  List<Object> get props => [quantityError];
}

class ItemFormProductIdErrorChanged extends ItemFormEvent {
  const ItemFormProductIdErrorChanged([
    this.productIdError = '',
  ]);

  final String productIdError;

  @override
  List<Object> get props => [productIdError];
}
