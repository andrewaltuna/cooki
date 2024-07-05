part of 'chat_view_model.dart';

class ChatState extends Equatable {
  const ChatState({
    this.messagingStatus = ViewModelStatus.initial,
    this.history = const [],
  });

  final ViewModelStatus messagingStatus;
  final List<String> history;

  ChatState copyWith({
    ViewModelStatus? messagingStatus,
    List<String>? history,
  }) {
    return ChatState(
      messagingStatus: messagingStatus ?? this.messagingStatus,
      history: history ?? this.history,
    );
  }

  @override
  List<Object> get props => [history];
}
