import 'package:collection/collection.dart';
import 'package:cooki/feature/preferences/data/enum/product_category.dart';
import 'package:cooki/feature/shopping_list/data/model/shopping_list_item.dart';
import 'package:equatable/equatable.dart';

typedef ShoppingListItemsByCategory
    = Map<ProductCategory, List<ShoppingListItem>>;

class ShoppingList extends Equatable {
  const ShoppingList({
    required this.id,
    required this.name,
    required this.budget,
    required this.items,
    required this.userId,
  });

  static const ShoppingList empty = ShoppingList(
    id: '',
    userId: '',
    name: '',
    budget: 0.0,
    items: [],
  );

  factory ShoppingList.fromJson(Map<String, dynamic> json) {
    final listItems = json['items'] as List?;
    return empty.copyWith(
      id: json['_id'],
      name: json['name'],
      budget: json['budget'],
      items: listItems
          ?.map(
            (item) => ShoppingListItem.fromJson(
              item,
            ),
          )
          .toList(),
      userId: json['userId'],
    );
  }

  final String id;
  final String userId;
  final String name;
  final num budget;
  final List<ShoppingListItem> items;

  ShoppingList copyWith({
    String? id,
    String? name,
    num? budget,
    List<ShoppingListItem>? items,
    String? userId,
  }) {
    return ShoppingList(
      id: id ?? this.id,
      name: name ?? this.name,
      budget: budget ?? this.budget,
      items: items ?? this.items,
      userId: userId ?? this.userId,
    );
  }

  bool get isEmpty => this == ShoppingList.empty;
  bool get isNotEmpty => !isEmpty;

  ShoppingListItemsByCategory get itemsByCategory => groupBy(
        items,
        (ShoppingListItem item) => item.product.category,
      );

  int get itemsCheckedCount =>
      items.where((item) => item.isChecked).toList().length;

  num get totalPrice =>
      items.map((item) => item.product.price * item.quantity).sum;

  ShoppingListItem itemById(String id) {
    return items.firstWhere(
      (item) => item.id == id,
      orElse: () => ShoppingListItem.empty,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        budget,
        items,
        userId,
      ];
}
