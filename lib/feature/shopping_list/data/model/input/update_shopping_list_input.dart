import 'package:cooki/feature/shopping_list/data/model/input/shopping_list_item_input.dart';
import 'package:equatable/equatable.dart';

class UpdateShoppingListInput extends Equatable {
  const UpdateShoppingListInput({
    required this.id,
    this.name,
    this.items,
    this.budget,
  });

  final String id;
  final String? name;
  final List<ShoppingListItemInput>? items;
  final double? budget;

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      if (name != null) 'name': name,
      if (budget != null) 'budget': budget,
    };
  }

  @override
  List<Object?> get props => [
        id,
        name,
        items,
        budget,
      ];
}
