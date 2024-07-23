import 'package:equatable/equatable.dart';

class UpdateShoppingListItemInput extends Equatable {
  const UpdateShoppingListItemInput({
    required this.id,
    required this.label,
    required this.productId,
    required this.quantity,
    required this.isChecked,
  });

  final String id;
  final String label;
  final String productId;
  final int quantity;
  final bool isChecked;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'label': label,
      'product': productId,
      'quantity': quantity,
      'isChecked': isChecked,
    };
  }

  UpdateShoppingListItemInput copyWith({
    String? id,
    String? label,
    String? productId,
    int? quantity,
    bool? isChecked,
  }) {
    return UpdateShoppingListItemInput(
      id: id ?? this.id,
      label: label ?? this.label,
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
      isChecked: isChecked ?? this.isChecked,
    );
  }

  @override
  List<Object?> get props => [
        id,
        label,
        productId,
        quantity,
        isChecked,
      ];
}
