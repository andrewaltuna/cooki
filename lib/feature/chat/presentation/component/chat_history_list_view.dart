import 'package:cooki/feature/chat/data/model/chat_message.dart';
import 'package:cooki/feature/chat/presentation/component/chat_message_view.dart';
import 'package:flutter/material.dart';

class ChatHistoryListView extends StatelessWidget {
  const ChatHistoryListView({
    required this.items,
    required this.scrollController,
    super.key,
  });

  final ScrollController scrollController;
  final List<ChatMessage> items;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: scrollController,
      itemCount: items.length,
      itemBuilder: (_, index) {
        final messageWidget = ChatMessageView(
          message: items[index],
        );

        if (index == 0) {
          return Padding(
            padding: const EdgeInsets.only(top: 16),
            child: messageWidget,
          );
        }

        return messageWidget;
      },
      separatorBuilder: (_, index) => const SizedBox(height: 16),
    );
  }
}
