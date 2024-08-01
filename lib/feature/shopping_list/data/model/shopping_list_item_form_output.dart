import 'package:equatable/equatable.dart';

class ShoppingListItemFormOutput extends Equatable {
  const ShoppingListItemFormOutput({
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
