import 'package:cooki/common/component/app_images.dart';
import 'package:cooki/common/component/button/custom_icon_button.dart';
import 'package:cooki/common/extension/screen_size.dart';
import 'package:cooki/common/theme/app_colors.dart';
import 'package:cooki/common/theme/app_text_styles.dart';
import 'package:cooki/feature/chat/data/model/chat_message.dart';
import 'package:cooki/feature/shopping_list/data/model/chat_shopping_list_item.dart';
import 'package:cooki/feature/shopping_list/presentation/component/shopping_list_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

const _screenWidthMult = 0.85;

class ChatMessageView extends StatelessWidget {
  const ChatMessageView({
    required this.message,
    super.key,
  });

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    final sender = message.sender;
    final isUserMessage = sender.isUser;

    final bodyColor = switch (sender) {
      ChatMessageSender.user => AppColors.fontSecondary,
      ChatMessageSender.cooki => AppColors.fontPrimary,
      ChatMessageSender.error => AppColors.fontWarning,
    };

    return Row(
      mainAxisAlignment:
          isUserMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 14,
          ),
          constraints: BoxConstraints(
            maxWidth: context.screenWidth * _screenWidthMult,
          ),
          decoration: BoxDecoration(
            color: isUserMessage
                ? AppColors.accent
                : AppColors.backgroundSecondary,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (sender.isCooki) ...[
                _CookiHeader(
                  convertibleItems: message.convertibleItems,
                ),
                const SizedBox(height: 8),
              ],
              _MessageBody(
                message: message.body,
                color: bodyColor,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _CookiHeader extends StatelessWidget {
  const _CookiHeader({
    required this.convertibleItems,
  });

  final List<ChatShoppingListItem> convertibleItems;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppImages.cookiChat.copyWith(height: 34),
        const SizedBox(width: 12),
        Text(
          'Cooki',
          style: AppTextStyles.titleMedium,
        ),
        if (convertibleItems.isNotEmpty) ...[
          const Spacer(),
          CustomIconButton(
            icon: Icons.shopping_cart_checkout,
            size: 34,
            padding: 0,
            backgroundColor: AppColors.accent,
            color: AppColors.fontSecondary,
            iconSize: 20,
            onPressed: () =>
                ShoppingListHelper.of(context).showGeminiCreateDialog(
              convertibleItems,
            ),
          ),
        ],
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
