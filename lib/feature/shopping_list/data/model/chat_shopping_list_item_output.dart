import 'package:equatable/equatable.dart';

class ChatShoppingListItemOutput extends Equatable {
  const ChatShoppingListItemOutput({
    required this.label,
    required this.productId,
    required this.quantity,
  });

  factory ChatShoppingListItemOutput.fromJson(Map<String, dynamic> json) {
    return ChatShoppingListItemOutput(
      label: json['label'] as String,
      productId: json['productId'] as String,
      quantity: json['quantity'] as int,
    );
  }

  final String label;
  final String productId;
  final int quantity;

  ChatShoppingListItemOutput copyWith({
    String? label,
    String? productId,
    int? quantity,
  }) {
    return ChatShoppingListItemOutput(
      label: label ?? this.label,
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  List<Object?> get props => [
        label,
        productId,
        quantity,
      ];
}
