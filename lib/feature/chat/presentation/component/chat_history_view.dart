import 'package:cooki/common/hook/use_on_widget_load.dart';
import 'package:cooki/feature/chat/presentation/component/chat_history_list_view.dart';
import 'package:cooki/feature/chat/presentation/component/chat_history_preset_view.dart';
import 'package:cooki/feature/chat/presentation/view_model/chat_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ChatHistoryView extends HookWidget {
  const ChatHistoryView({
    required this.chatFocusNode,
    required this.chatController,
    required this.scrollController,
    super.key,
  });

  final FocusNode chatFocusNode;
  final TextEditingController chatController;
  final ScrollController scrollController;

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((callback) {
      if (!scrollController.hasClients) return;

      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 800),
        curve: Curves.fastOutSlowIn,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    useOnWidgetLoad(
      _scrollToBottom,
    );

    return BlocConsumer<ChatViewModel, ChatState>(
      listenWhen: (previous, current) => previous.history != current.history,
      listener: (_, __) => _scrollToBottom(),
      builder: (context, state) {
        return _AnimatedSwitcherWrapper(
          child: state.history.isEmpty
              ? ChatHistoryPresetView(
                  chatFocusNode: chatFocusNode,
                  chatController: chatController,
                )
              : ChatHistoryListView(
                  scrollController: scrollController,
                  items: state.history,
                ),
        );
      },
    );
  }
}

class _AnimatedSwitcherWrapper extends StatelessWidget {
  const _AnimatedSwitcherWrapper({
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      switchInCurve: Curves.easeOut,
      switchOutCurve: Curves.easeIn,
      duration: const Duration(milliseconds: 500),
      transitionBuilder: (child, animation) {
        final position = Tween<Offset>(
          begin: const Offset(0, -1),
          end: Offset.zero,
        ).animate(animation);

        return SlideTransition(
          position: position,
          child: child,
        );
      },
      child: child,
    );
  }
}
