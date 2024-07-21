import 'package:cooki/feature/product/data/model/output/product_output.dart';
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
    product: ProductOutput.empty,
    quantity: 0,
    isChecked: false,
  );

  factory ShoppingListItem.fromJson(Map<String, dynamic> json) {
    return empty.copyWith(
      id: json['id'],
      label: json['label'],
      product: ProductOutput.fromJson(json['product']),
      quantity: json['quantity'],
      isChecked: json['isChecked'],
    );
  }

  final String id;
  final String label;
  final ProductOutput product;
  final int quantity;
  final bool isChecked;

  ShoppingListItem copyWith({
    String? id,
    String? label,
    ProductOutput? product,
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

  // TODO: Remove once query is placed
  static List<ShoppingListItem> getDummyItems() {
    List<ShoppingListItem> dummyItems = [];
    for (var i = 0; i < 10; i++) {
      dummyItems.add(ShoppingListItem(
        id: 'dummy-${i}',
        label: 'dummy item $i',
        product: ProductOutput.getDummyProducts()[i],
        quantity: 1,
        isChecked: false,
      ));
    }

    return dummyItems;
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
