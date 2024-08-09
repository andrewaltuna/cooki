import 'package:cooki/common/helper/dialog_helper.dart';
import 'package:cooki/feature/chat/presentation/component/certifications_page_view.dart';
import 'package:flutter/material.dart';

class ChatHelper {
  const ChatHelper._(this._context);

  factory ChatHelper.of(BuildContext context) => ChatHelper._(context);

  final BuildContext _context;

  void showCertificationsDialog() {
    DialogHelper.of(_context).showCustomDialog(
      CustomDialogArgs(
        barrierDismissable: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
        constraints: const BoxConstraints(maxHeight: 375),
        builder: (_) => const SizedBox.expand(
          child: CertificationsPageView(
            title: 'Our Sustainability Badges',
          ),
        ),
      ),
    );
  }
}
