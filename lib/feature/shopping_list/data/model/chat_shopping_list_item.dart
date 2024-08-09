import 'package:equatable/equatable.dart';

class ChatShoppingListItem extends Equatable {
  const ChatShoppingListItem({
    required this.productId,
    required this.quantity,
  });

  factory ChatShoppingListItem.fromJson(Map<String, dynamic> json) {
    return ChatShoppingListItem(
      productId: json['productId'] as String,
      quantity: json['quantity'] as int,
    );
  }

  final String productId;
  final int quantity;

  ChatShoppingListItem copyWith({
    String? productId,
    int? quantity,
  }) {
    return ChatShoppingListItem(
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'quantity': quantity,
    };
  }

  @override
  List<Object?> get props => [
        productId,
        quantity,
      ];
}
