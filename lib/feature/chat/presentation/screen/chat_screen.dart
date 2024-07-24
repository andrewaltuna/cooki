import 'package:cooki/common/hook/use_on_widget_load.dart';
import 'package:cooki/feature/account/presentation/view_model/account_view_model.dart';
import 'package:cooki/feature/chat/presentation/component/chat_form_view.dart';
import 'package:cooki/feature/chat/presentation/component/chat_history_view.dart';
import 'package:cooki/feature/preferences/presentation/helper/preferences_helper.dart';
import 'package:flutter/material.dart';
import 'package:cooki/common/component/main_scaffold.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ChatScreen extends HookWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final chatController = useTextEditingController();
    final chatFocusNode = useFocusNode();
    final scrollController = useScrollController();

    useOnWidgetLoad(() {
      final shouldShowInitialPrefsModal =
          context.read<AccountViewModel>().state.shouldShowInitialPrefsModal;

      if (shouldShowInitialPrefsModal) {
        PreferencesHelper.of(context).showPreferencesModal();
      }
    });

    return MainScaffold(
      title: 'Home',
      body: Column(
        children: [
          Expanded(
            child: ChatHistoryView(
              chatFocusNode: chatFocusNode,
              chatController: chatController,
              scrollController: scrollController,
            ),
          ),
          const SizedBox(height: 16),
          ChatFormView(
            chatFocusNode: chatFocusNode,
            chatController: chatController,
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
