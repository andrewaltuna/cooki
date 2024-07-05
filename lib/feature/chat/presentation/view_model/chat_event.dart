part of 'chat_view_model.dart';

sealed class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class ChatMessageSent extends ChatEvent {
  const ChatMessageSent(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
