import 'package:cooki/feature/chat/data/model/chat_message.dart';
import 'package:cooki/feature/chat/data/remote/chat_remote_source.dart';
import 'package:cooki/feature/chat/data/repository/chat_repository_interface.dart';

class ChatRepository implements ChatRepositoryInterface {
  const ChatRepository(this._remoteSource);

  final ChatRemoteSource _remoteSource;

  @override
  Future<ChatMessage> sendMessage(
    String message, {
    required bool isFirstMessage,
  }) async {
    return await _remoteSource.chat(
      message,
      isFirstMessage,
    );
  }
}
