import 'package:equatable/equatable.dart';

class ShoppingListItemInput extends Equatable {
  const ShoppingListItemInput({
    required this.label,
    required this.productId,
    required this.quantity,
  });

  final String label;
  final String productId;
  final int quantity;

  // * Form helper
  ShoppingListItemInput copyWith({
    String? shoppingListId,
    String? label,
    String? productId,
    int? quantity,
  }) {
    return ShoppingListItemInput(
      label: label ?? this.label,
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'label': label,
      'product': productId,
      'quantity': quantity,
    };
  }

  @override
  List<Object?> get props => [
        label,
        productId,
        quantity,
      ];
}
