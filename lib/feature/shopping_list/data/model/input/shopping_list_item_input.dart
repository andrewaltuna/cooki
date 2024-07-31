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

  @override
  List<Object?> get props => [
        label,
        productId,
        quantity,
      ];
}
