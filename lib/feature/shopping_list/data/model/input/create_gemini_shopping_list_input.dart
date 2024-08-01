import 'package:cooki/feature/shopping_list/data/model/chat_shopping_list_item.dart';
import 'package:equatable/equatable.dart';

class CreateGeminiShoppingListInput extends Equatable {
  const CreateGeminiShoppingListInput({
    required this.name,
    required this.items,
  });

  final String name;
  final List<ChatShoppingListItem> items;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'items': items.map((item) => item.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props => [
        name,
        items,
      ];
}
