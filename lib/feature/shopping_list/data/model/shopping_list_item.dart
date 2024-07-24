import 'package:cooki/feature/product/data/model/product.dart';
import 'package:equatable/equatable.dart';

class ShoppingListItem extends Equatable {
  const ShoppingListItem({
    required this.id,
    required this.label,
    required this.product,
    required this.quantity,
    required this.isChecked,
  });

  static const ShoppingListItem empty = ShoppingListItem(
    id: '',
    label: '',
    product: Product.empty,
    quantity: 0,
    isChecked: false,
  );

  factory ShoppingListItem.fromJson(Map<String, dynamic> json) {
    return empty.copyWith(
      id: json['_id'],
      label: json['label'],
      product: Product.fromJson(json['product']),
      quantity: json['quantity'],
      isChecked: json['isChecked'],
    );
  }

  final String id;
  final String label;
  final Product product;
  final int quantity;
  final bool isChecked;

  ShoppingListItem copyWith({
    String? id,
    String? label,
    Product? product,
    int? quantity,
    bool? isChecked,
  }) {
    return ShoppingListItem(
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
