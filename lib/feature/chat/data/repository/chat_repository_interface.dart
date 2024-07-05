abstract interface class ChatRepositoryInterface {
  Future<String> sendMessage(String message);
}
