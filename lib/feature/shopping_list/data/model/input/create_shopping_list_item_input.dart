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

  Map<String, dynamic> toJson() {
    return {
      'shoppingListId': shoppingListId,
      'label': label,
      'productId': productId,
      'quantity': quantity,
    };
  }

  @override
  List<Object?> get props => [
        shoppingListId,
        label,
        productId,
        quantity,
      ];
}
