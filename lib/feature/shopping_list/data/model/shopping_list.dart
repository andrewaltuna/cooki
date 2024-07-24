import 'package:cooki/feature/shopping_list/data/model/output/shopping_list_item_output.dart';
import 'package:equatable/equatable.dart';

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
    final listItems = json['items'] as List;

    return empty.copyWith(
      id: json['_id'],
      name: json['name'],
      budget: json['budget'],
      items: listItems.map((item) => ShoppingListItem.fromJson(item)).toList(),
      userId: json['userId'],
    );
  }

  // TODO: Place shopping list items here
  final String id;
  final String userId;
  final String name;
  final double budget;
  final List<ShoppingListItem> items;

  ShoppingList copyWith({
    String? id,
    String? name,
    double? budget,
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

  @override
  List<Object?> get props => [
        id,
        name,
        budget,
        items,
        userId,
      ];
}
