import 'package:cooki/feature/shopping_list/data/model/output/shopping_list_item_output.dart';
import 'package:equatable/equatable.dart';

class ShoppingListOutput extends Equatable {
  const ShoppingListOutput(
      {required this.id, required this.name, required this.items});

  static const ShoppingListOutput empty =
      ShoppingListOutput(id: '', name: '', items: []);

  factory ShoppingListOutput.fromJson(Map<String, dynamic> json) {
    return empty.copyWith(id: json['id'], name: json['name']);
  }

  // TODO: Place shopping list items here
  final String id;
  final String name;
  final List<ShoppingListItemOutput> items;

  ShoppingListOutput copyWith(
      {String? id, String? name, List<ShoppingListItemOutput>? items}) {
    return ShoppingListOutput(
        id: id ?? this.id, name: name ?? this.name, items: items ?? this.items);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [id, name, items];
}
