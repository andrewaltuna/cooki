import 'package:cooki/feature/shopping_list/data/model/chat_shopping_list_item.dart';
import 'package:equatable/equatable.dart';

class ChatMessage extends Equatable {
  const ChatMessage({
    required this.sender,
    required this.body,
    required this.convertibleItems,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    final items = json['products'] as List;

    return ChatMessage(
      sender: ChatMessageSender.cooki,
      body: json['message'],
      convertibleItems: items
          .map(
            (item) => ChatShoppingListItem.fromJson(
              item as Map<String, dynamic>,
            ),
          )
          .toList(),
    );
  }

  factory ChatMessage.user(String message) {
    return ChatMessage(
      sender: ChatMessageSender.user,
      body: message,
      convertibleItems: const [],
    );
  }

  factory ChatMessage.error([String? message]) {
    return ChatMessage(
      sender: ChatMessageSender.error,
      body: '\u24D8 ${message ?? 'An error occurred. Please try again.'}',
      convertibleItems: const [],
    );
  }

  final ChatMessageSender sender;
  final String body;
  final List<ChatShoppingListItem> convertibleItems;

  bool get isConvertibleToShoppingList => convertibleItems.isNotEmpty;

  @override
  List<Object?> get props => [
        sender,
        body,
      ];
}

enum ChatMessageSender {
  user,
  cooki,
  error;

  bool get isUser => this == user;
  bool get isCooki => this == cooki;
  bool get isError => this == error;
}
