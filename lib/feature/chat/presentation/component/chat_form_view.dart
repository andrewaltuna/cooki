import 'package:cooki/common/component/form/custom_form_field.dart';
import 'package:cooki/common/component/indicator/loading_indicator.dart';
import 'package:cooki/common/theme/app_colors.dart';
import 'package:cooki/feature/chat/presentation/view_model/chat_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatFormView extends StatelessWidget {
  const ChatFormView({
    super.key,
    required this.chatFocusNode,
    required this.chatController,
  });

  final FocusNode chatFocusNode;
  final TextEditingController chatController;

  void _onMessageSent(BuildContext context) {
    if (chatController.text.isEmpty) return;

    context.read<ChatViewModel>().add(
          ChatMessageSent(chatController.text),
        );

    chatController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ChatViewModel, ChatState, bool>(
      selector: (state) => state.messagingStatus.isLoading,
      builder: (context, isLoading) {
        return Row(
          children: [
            Expanded(
              child: CustomFormField(
                focusNode: chatFocusNode,
                controller: chatController,
                hintText: 'Message',
                maxLines: null,
                inputBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  borderSide: BorderSide(
                    width: 1.5,
                    color: AppColors.backgroundTextField,
                  ),
                ),
                textInputAction: TextInputAction.newline,
                fillColor: null,
              ),
            ),
            IconButton(
              icon: isLoading
                  ? const LoadingIndicator()
                  : const Icon(
                      Icons.send_rounded,
                      color: AppColors.fontPrimary,
                      size: 20,
                    ),
              style: IconButton.styleFrom(
                backgroundColor: AppColors.accent,
                disabledBackgroundColor: AppColors.backgroundTextField,
              ),
              onPressed: () => isLoading ? null : _onMessageSent(context),
            ),
          ],
        );
      },
    );
  }
}
