import 'package:equatable/equatable.dart';

class CreateShoppingListItemInput extends Equatable {
  const CreateShoppingListItemInput({
    required this.shoppingListId,
    required this.label,
    required this.productId,
    required this.quantity,
  });

  final String shoppingListId;
  final String label;
  final String productId;
  final int quantity;

  // * Form helper
  CreateShoppingListItemInput copyWith({
    String? shoppingListId,
    String? label,
    String? productId,
    int? quantity,
  }) {
    return CreateShoppingListItemInput(
      shoppingListId: shoppingListId ?? this.shoppingListId,
      label: label ?? this.label,
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  List<Object?> get props => [
        shoppingListId,
        label,
        productId,
        quantity,
      ];
}
