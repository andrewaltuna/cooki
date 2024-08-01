part of 'chat_view_model.dart';

class ChatState extends Equatable {
  const ChatState({
    this.messagingStatus = ViewModelStatus.initial,
    this.history = const [],
  });

  final ViewModelStatus messagingStatus;
  final List<ChatMessage> history;

  ChatState copyWith({
    ViewModelStatus? messagingStatus,
    List<ChatMessage>? history,
  }) {
    return ChatState(
      messagingStatus: messagingStatus ?? this.messagingStatus,
      history: history ?? this.history,
    );
  }

  @override
  List<Object> get props => [history];
}
