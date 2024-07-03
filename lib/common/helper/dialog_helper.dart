import 'package:flutter/material.dart';
import 'package:cooki/common/component/button/primary_button.dart';
import 'package:cooki/common/theme/app_text_styles.dart';

class DialogHelper {
  const DialogHelper(this._context);

  factory DialogHelper.of(BuildContext context) => DialogHelper(context);

  final BuildContext _context;

  Future<void> show(DialogArguments args) async {
    await showDialog(
      context: _context,
      barrierDismissible: args.barrierDismissable,
      builder: (context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  args.title,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.subtitle,
                ),
                const SizedBox(height: 16),
                Flexible(
                  child: Text(
                    args.message,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.body,
                  ),
                ),
                const SizedBox(height: 32),
                PrimaryButton(
                  label: args.confirmText,
                  onPress: () {
                    Navigator.of(context).pop();
                    args.onConfirm();
                  },
                  height: 50,
                  width: 150,
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    args.onCancel?.call();
                  },
                  child: Text(
                    args.dismissText,
                    style: AppTextStyles.body,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class DialogArguments {
  const DialogArguments({
    required this.title,
    required this.message,
    required this.onConfirm,
    this.confirmText = 'Confirm',
    this.dismissText = 'Dismiss',
    this.onCancel,
    this.barrierDismissable = false,
  });

  final String title;
  final String message;
  final VoidCallback onConfirm;
  final String confirmText;
  final String dismissText;
  final VoidCallback? onCancel;
  final bool barrierDismissable;
}
