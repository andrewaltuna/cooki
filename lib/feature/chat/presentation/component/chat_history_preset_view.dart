import 'package:cooki/common/component/button/ink_well_button.dart';
import 'package:cooki/common/theme/app_colors.dart';
import 'package:cooki/common/theme/app_text_styles.dart';
import 'package:cooki/feature/chat/data/enum/chat_preset.dart';
import 'package:cooki/feature/chat/presentation/helper/chat_helper.dart';
import 'package:cooki/feature/chat/presentation/view_model/chat_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatHistoryPresetView extends StatelessWidget {
  const ChatHistoryPresetView({
    required this.chatFocusNode,
    required this.chatController,
    super.key,
  });

  static const _chatPresets = ChatPreset.values;

  final FocusNode chatFocusNode;
  final TextEditingController chatController;

  void _onPresetSelected(
    BuildContext context,
    ChatPreset preset,
  ) {
    // Send preset message automatically if it does not contain selection target
    if (!preset.textPreset.contains(ChatPreset.selectionTarget)) {
      context.read<ChatViewModel>().add(
            ChatMessageSent(preset.textPreset),
          );

      return;
    }

    // Otherwise, set the text and focus on the selection target
    chatController.text = preset.textPreset;

    if (!chatFocusNode.hasFocus) {
      chatFocusNode.requestFocus();
    }

    final selectionTargetIndex =
        chatController.text.indexOf(ChatPreset.selectionTarget);
    final startIndex =
        selectionTargetIndex + ChatPreset.selectionTarget.length - 1;

    chatController.selection = TextSelection(
      baseOffset: startIndex,
      extentOffset: startIndex + 1,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Row(
          children: [
            Text(
              'How can I help you today?',
              style: AppTextStyles.titleLarge,
              textAlign: TextAlign.start,
            ),
          ],
        ),
        const SizedBox(height: 24),
        Expanded(
          child: GridView.builder(
            itemCount: _chatPresets.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemBuilder: (context, index) {
              final preset = _chatPresets[index];

              return _ChatPresetItem(
                preset: preset,
                onPressed: () => _onPresetSelected(context, preset),
                onInfoPressed: preset.isEcoWarrior
                    ? () => ChatHelper.of(context).showCertificationsDialog()
                    : null,
              );
            },
          ),
        ),
      ],
    );
  }
}

class _ChatPresetItem extends StatelessWidget {
  const _ChatPresetItem({
    required this.preset,
    required this.onPressed,
    this.onInfoPressed,
  });

  final ChatPreset preset;
  final VoidCallback onPressed;
  final VoidCallback? onInfoPressed;

  @override
  Widget build(BuildContext context) {
    return InkWellButton(
      onPressed: onPressed,
      circularPadding: 16,
      circularBorderRadius: 16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          preset.icon,
          const SizedBox(height: 12),
          GestureDetector(
            onTap: onInfoPressed,
            child: Row(
              children: [
                Flexible(
                  child: Text(
                    preset.displayLabel,
                    style: onInfoPressed == null
                        ? AppTextStyles.subtitle
                        : AppTextStyles.subtitle.copyWith(
                            color: AppColors.accent,
                            decorationColor: AppColors.accent,
                            decoration: TextDecoration.underline,
                            decorationStyle: TextDecorationStyle.dashed,
                            decorationThickness: 1.5,
                          ),
                  ),
                ),
                if (onInfoPressed != null) ...[
                  const SizedBox(width: 4),
                  const Icon(
                    Icons.info_outline,
                    color: AppColors.accent,
                    size: 20,
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            preset.description,
            style: AppTextStyles.bodySmall,
          ),
        ],
      ),
    );
  }
}
