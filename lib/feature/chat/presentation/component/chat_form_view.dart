import 'package:cooki/common/component/button/custom_icon_button.dart';
import 'package:cooki/common/component/form/custom_form_field.dart';
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
      selector: (state) => state.status.isLoading,
      builder: (context, isLoading) {
        return Row(
          children: [
            Expanded(
              child: CustomFormField(
                focusNode: chatFocusNode,
                controller: chatController,
                hintText: 'Message',
                minLines: 1,
                maxLines: 5,
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
            CustomIconButton(
              icon: Icons.send_rounded,
              iconSize: 20,
              padding: 0,
              color: AppColors.fontSecondary,
              backgroundColor: AppColors.accent,
              isLoading: isLoading,
              onPressed: () => _onMessageSent(context),
            ),
          ],
        );
      },
    );
  }
}
