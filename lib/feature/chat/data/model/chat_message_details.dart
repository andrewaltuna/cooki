import 'package:equatable/equatable.dart';

class ChatMessageDetails extends Equatable {
  const ChatMessageDetails({
    required this.sender,
    required this.message,
  });

  factory ChatMessageDetails.user(String message) {
    return ChatMessageDetails(
      sender: ChatMessageSender.user,
      message: message,
    );
  }

  factory ChatMessageDetails.cooki(String message) {
    return ChatMessageDetails(
      sender: ChatMessageSender.cooki,
      message: message,
    );
  }

  final ChatMessageSender sender;
  final String message;

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
