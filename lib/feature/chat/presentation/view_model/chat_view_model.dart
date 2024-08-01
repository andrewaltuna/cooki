import 'package:cooki/common/enum/view_model_status.dart';
import 'package:cooki/feature/chat/data/model/chat_message.dart';
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

  Future<void> _onMessageSent(
    ChatMessageSent event,
    Emitter<ChatState> emit,
  ) async {
    try {
      final isFirstMessage = state.history.isEmpty;

      emit(
        state.copyWith(
          status: ViewModelStatus.loading,
          history: [
            ...state.history,
            ChatMessage.user(event.message),
          ],
        ),
      );

      final result = await _chatRepository.sendMessage(
        event.message,
        isFirstMessage: isFirstMessage,
      );

      emit(
        state.copyWith(
          status: ViewModelStatus.success,
          history: [
            ...state.history,
            result,
          ],
        ),
      );
    } on Exception catch (error) {
      emit(
        state.copyWith(
          status: ViewModelStatus.error,
          history: [
            ...state.history,
            ChatMessage.error(),
          ],
          error: error,
        ),
      );
    }
  }
}
