import 'package:cooki/common/component/form/custom_form_field.dart';
import 'package:cooki/common/hook/use_on_widget_load.dart';
import 'package:cooki/feature/account/presentation/view_model/account_view_model.dart';
import 'package:cooki/feature/chat/presentation/component/chat_view.dart';
import 'package:cooki/feature/chat/presentation/view_model/chat_view_model.dart';
import 'package:cooki/feature/preferences/presentation/helper/preferences_helper.dart';
import 'package:flutter/material.dart';
import 'package:cooki/common/component/main_scaffold.dart';
import 'package:cooki/feature/chat/presentation/component/proximity_indicator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

// TODO: Complete implementation; for demonstration purposes only;
class ChatScreen extends HookWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textController = useTextEditingController();

    useOnWidgetLoad(() {
      final shouldShowInitialPrefsModal =
          context.read<AccountViewModel>().state.shouldShowInitialPrefsModal;

      if (shouldShowInitialPrefsModal) {
        PreferencesHelper.of(context).showPreferencesModal();
      }
    });

    return MainScaffold(
      body: Column(
        children: [
          const SizedBox(height: 16),
          const BeaconProximityIndicator(),
          const Expanded(
            child: ChatHistoryView(),
          ),
          CustomFormField(
            controller: textController,
            onSubmitted: (value) {
              textController.clear();

              context.read<ChatViewModel>().add(
                    ChatMessageSent(value),
                  );
            },
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
