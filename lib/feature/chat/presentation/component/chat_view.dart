import 'package:cooki/feature/chat/presentation/view_model/chat_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatHistoryView extends StatelessWidget {
  const ChatHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatViewModel, ChatState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            children: [
              for (var message in state.history) Text(message),
            ],
          ),
        );
      },
    );
  }
}
