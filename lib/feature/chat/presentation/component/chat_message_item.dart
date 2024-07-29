import 'package:cooki/common/extension/screen_size.dart';
import 'package:cooki/common/theme/app_colors.dart';
import 'package:cooki/common/theme/app_text_styles.dart';
import 'package:cooki/feature/chat/data/model/chat_message_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

const _screenWidthMult = 0.85;

class ChatMessageItem extends StatelessWidget {
  const ChatMessageItem({
    required this.messageDetails,
    super.key,
  });

  final ChatMessageDetails messageDetails;

  @override
  Widget build(BuildContext context) {
    final isSenderUser = messageDetails.sender.isUser;

    return Row(
      mainAxisAlignment:
          isSenderUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          constraints: BoxConstraints(
            maxWidth: context.screenWidth * _screenWidthMult,
          ),
          decoration: BoxDecoration(
            color:
                isSenderUser ? AppColors.accent : AppColors.backgroundSecondary,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (!isSenderUser) ...[
                Text(
                  'Cooki',
                  style: AppTextStyles.titleMedium,
                ),
                const SizedBox(height: 8),
              ],
              _MessageBody(
                message: messageDetails.message,
                color: isSenderUser
                    ? AppColors.fontSecondary
                    : AppColors.fontPrimary,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _MessageBody extends StatelessWidget {
  const _MessageBody({
    required this.message,
    required this.color,
  });

  final String message;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final header = AppTextStyles.bodyLarge.copyWith(
      color: color,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    );
    final body = AppTextStyles.bodyLarge.copyWith(
      color: color,
    );

    final styleSheet = MarkdownStyleSheet(
      h1: header,
      h2: header,
      h3: header,
      h4: header,
      h5: header,
      h6: header,
      p: body,
      code: body,
      blockquote: body,
    );

    return MarkdownBody(
      styleSheet: styleSheet,
      data: message,
      softLineBreak: true,
      bulletBuilder: (_) => Text(
        '\u25CF',
        style: body,
      ),
    );
  }
}
