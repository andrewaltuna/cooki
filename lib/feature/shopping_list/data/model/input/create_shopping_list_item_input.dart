import 'package:equatable/equatable.dart';

class CreateShoppingListItemInput extends Equatable {
  const CreateShoppingListItemInput({
    required this.label,
    required this.productId,
    required this.quantity,
  });

  final String label;
  final String productId;
  final int quantity;

  @override
  // TODO: implement props
  List<Object?> get props => [
        label,
        productId,
        quantity,
      ];
}
