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
    Map<String, dynamic> data = {
      '_id': id,
    };

    if (name != null) data['name'] = name;
    if (items != null) {
      data['items'] = items!.map((item) => item.toJson()).toList();
    }
    if (budget != null) data['budget'] = budget;
    return data;
  }

  @override
  List<Object?> get props => [
        id,
        name,
        items,
        budget,
      ];
}
