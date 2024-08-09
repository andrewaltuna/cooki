import 'package:equatable/equatable.dart';

class CreateShoppingListItemInput extends Equatable {
  const CreateShoppingListItemInput({
    required this.shoppingListId,
    required this.productId,
    required this.quantity,
  });

  final String shoppingListId;
  final String productId;
  final int quantity;

  Map<String, dynamic> toJson() {
    return {
      'shoppingListId': shoppingListId,
      // Unused, fill in with productId
      'label': productId,
      'productId': productId,
      'quantity': quantity,
    };
  }

  @override
  List<Object?> get props => [
        shoppingListId,
        productId,
        quantity,
      ];
}
