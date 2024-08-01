part of 'chat_view_model.dart';

class ChatState extends Equatable {
  const ChatState({
    this.status = ViewModelStatus.initial,
    this.history = const [],
    this.error,
  });

  final ViewModelStatus status;
  final List<ChatMessage> history;
  final Exception? error;

  ChatState copyWith({
    ViewModelStatus? status,
    List<ChatMessage>? history,
    Exception? error,
  }) {
    return ChatState(
      status: status ?? this.status,
      history: history ?? this.history,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
        status,
        history,
        error,
      ];
}
