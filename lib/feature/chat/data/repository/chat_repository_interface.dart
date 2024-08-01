import 'package:cooki/feature/chat/data/model/chat_message.dart';

abstract interface class ChatRepositoryInterface {
  Future<ChatMessage> sendMessage(
    String message, {
    required bool isFirstMessage,
  });
}
