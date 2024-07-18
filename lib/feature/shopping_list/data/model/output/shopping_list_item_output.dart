import 'dart:convert';

import 'package:cooki/feature/shopping_list/data/model/output/product_output.dart';
import 'package:equatable/equatable.dart';

class ShoppingListItemOutput extends Equatable {
  const ShoppingListItemOutput({
    required this.id,
    required this.label,
    required this.product,
    required this.quantity,
    required this.isChecked,
  });

  static const ShoppingListItemOutput empty = ShoppingListItemOutput(
    id: '',
    label: '',
    product: ProductOutput.empty,
    quantity: 0,
    isChecked: false,
  );

  factory ShoppingListItemOutput.fromJson(Map<String, dynamic> json) {
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

  ShoppingListItemOutput copyWith({
    String? id,
    String? label,
    ProductOutput? product,
    int? quantity,
    bool? isChecked,
  }) {
    return ShoppingListItemOutput(
      id: id ?? this.id,
      label: label ?? this.label,
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
      isChecked: isChecked ?? this.isChecked,
    );
  }

  // TODO: Remove once query is placed
  static List<ShoppingListItemOutput> getDummyItems() {
    List<ShoppingListItemOutput> dummyItems = [];
    for (var i = 0; i < 10; i++) {
      dummyItems.add(ShoppingListItemOutput(
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
