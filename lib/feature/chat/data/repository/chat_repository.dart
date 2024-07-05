import 'package:cooki/feature/chat/data/remote/chat_remote_source.dart';
import 'package:cooki/feature/chat/data/repository/chat_repository_interface.dart';

class ChatRepository implements ChatRepositoryInterface {
  const ChatRepository(this._remoteSource);

  final ChatRemoteSource _remoteSource;

  @override
  Future<String> sendMessage(String message) async {
    return await _remoteSource.createGeminiHealthCheck(message);
  }
}