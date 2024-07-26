import 'package:equatable/equatable.dart';

class UpdateShoppingListItemInput extends Equatable {
  const UpdateShoppingListItemInput({
    this.id,
    this.label,
    this.productId,
    this.quantity,
    this.isChecked,
  });

  final String? id;
  final String? label;
  final String? productId;
  final int? quantity;
  final bool? isChecked;

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      if (label != null) 'label': label,
      if (productId != null) 'productId': productId,
      if (quantity != null) 'quantity': quantity,
      if (isChecked != null) 'isInCart': isChecked,
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
