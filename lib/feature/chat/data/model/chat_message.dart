import 'package:cooki/feature/product/data/model/product.dart';
import 'package:equatable/equatable.dart';

class ChatMessage extends Equatable {
  const ChatMessage({
    required this.sender,
    required this.message,
    required this.products,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    final products = json['products'] as List;

    return ChatMessage(
      sender: ChatMessageSender.cooki,
      message: json['message'],
      products: products
          .map((item) => Product.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  factory ChatMessage.user(String message) {
    return ChatMessage(
      sender: ChatMessageSender.user,
      message: message,
      products: const [],
    );
  }

  final ChatMessageSender sender;
  final String message;
  final List<Product> products;

  bool get isConvertibleToShoppingList => products.isNotEmpty;

  @override
  List<Object?> get props => [
        sender,
        message,
      ];
}

enum ChatMessageSender {
  user,
  cooki;

  bool get isUser => this == user;
  bool get isCooki => this == cooki;
}
