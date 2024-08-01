import 'package:equatable/equatable.dart';

class ChatShoppingListItem extends Equatable {
  const ChatShoppingListItem({
    required this.label,
    required this.productId,
    required this.quantity,
  });

  factory ChatShoppingListItem.fromJson(Map<String, dynamic> json) {
    return ChatShoppingListItem(
      label: json['label'] as String,
      productId: json['productId'] as String,
      quantity: json['quantity'] as int,
    );
  }

  final String label;
  final String productId;
  final int quantity;

  ChatShoppingListItem copyWith({
    String? label,
    String? productId,
    int? quantity,
  }) {
    return ChatShoppingListItem(
      label: label ?? this.label,
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'label': label,
      'productId': productId,
      'quantity': quantity,
    };
  }

  @override
  List<Object?> get props => [
        label,
        productId,
        quantity,
      ];
}
