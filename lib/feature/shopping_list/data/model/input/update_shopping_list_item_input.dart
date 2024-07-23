import 'package:cooki/feature/product/data/model/output/product_output.dart';
import 'package:equatable/equatable.dart';

class UpdateShoppingListItemInput extends Equatable {
  const UpdateShoppingListItemInput({
    required this.id,
    required this.label,
    required this.product,
    required this.quantity,
    required this.isChecked,
  });

  final String id;
  final String label;
  final ProductOutput product;
  final int quantity;
  final bool isChecked;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'label': label,
      'product': product.toJson(),
      'quantity': quantity,
      'isChecked': isChecked,
    };
  }

  UpdateShoppingListItemInput copyWith({
    String? id,
    String? label,
    ProductOutput? product,
    int? quantity,
    bool? isChecked,
  }) {
    return UpdateShoppingListItemInput(
      id: id ?? this.id,
      label: label ?? this.label,
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
      isChecked: isChecked ?? this.isChecked,
    );
  }

  @override
  List<Object?> get props => [
        id,
        label,
        product,
        quantity,
        isChecked,
      ];
}
