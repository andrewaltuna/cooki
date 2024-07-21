import 'package:cooki/feature/shopping_list/data/model/output/shopping_list_item_output.dart';
import 'package:equatable/equatable.dart';

class ShoppingListOutput extends Equatable {
  const ShoppingListOutput({
    required this.id,
    required this.name,
    required this.budget,
    required this.items,
  });

  static const ShoppingListOutput empty = ShoppingListOutput(
    id: '',
    name: '',
    budget: 0.0,
    items: [],
  );

  factory ShoppingListOutput.fromJson(Map<String, dynamic> json) {
    return empty.copyWith(
      id: json['id'],
      name: json['name'],
    );
  }

  // TODO: Place shopping list items here
  final String id;
  final String name;
  final double budget;
  final List<ShoppingListItem> items;

  ShoppingListOutput copyWith({
    String? id,
    String? name,
    double? budget,
    List<ShoppingListItem>? items,
  }) {
    return ShoppingListOutput(
      id: id ?? this.id,
      name: name ?? this.name,
      budget: budget ?? this.budget,
      items: items ?? this.items,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        budget,
        items,
      ];
}
