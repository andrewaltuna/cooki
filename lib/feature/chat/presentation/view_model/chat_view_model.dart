import 'package:cooki/common/enum/view_model_status.dart';
import 'package:cooki/feature/chat/data/repository/chat_repository_interface.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatViewModel extends Bloc<ChatEvent, ChatState> {
  ChatViewModel(this._chatRepository) : super(const ChatState()) {
    on<ChatMessageSent>(_onMessageSent);
  }

  final ChatRepositoryInterface _chatRepository;

  // TODO: For demonstration only
  Future<void> _onMessageSent(
    ChatMessageSent event,
    Emitter<ChatState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          messagingStatus: ViewModelStatus.loading,
          history: [...state.history, event.message],
        ),
      );

      final result = await _chatRepository.sendMessage(event.message);

      emit(
        state.copyWith(
          messagingStatus: ViewModelStatus.success,
          history: [...state.history, result],
        ),
      );
    } catch (e) {
      emit(state.copyWith(messagingStatus: ViewModelStatus.error));
    }
  }
}
