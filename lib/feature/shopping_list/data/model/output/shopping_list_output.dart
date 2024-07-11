import 'package:equatable/equatable.dart';

class ShoppingListOutput extends Equatable {
  const ShoppingListOutput({required this.id, required this.name});

  static const ShoppingListOutput empty = ShoppingListOutput(id: '', name: '');

  factory ShoppingListOutput.fromJson(Map<String, dynamic> json) {
    return empty.copyWith(
      id: json['id'],
      name: json['name']
    );
  }

  // TODO: Place shopping list items here
  final String id;
  final String name;

  ShoppingListOutput copyWith({
    String? id,
    String? name
  }) {
    return ShoppingListOutput(
      id: id ?? this.id,
      name: name ?? this.name
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
    id,
    name
  ];
}