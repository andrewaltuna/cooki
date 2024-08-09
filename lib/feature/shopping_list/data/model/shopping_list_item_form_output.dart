import 'package:equatable/equatable.dart';

class ShoppingListItemFormOutput extends Equatable {
  const ShoppingListItemFormOutput({
    required this.productId,
    required this.quantity,
  });

  final String productId;
  final int quantity;

  @override
  List<Object?> get props => [
        productId,
        quantity,
      ];
}
