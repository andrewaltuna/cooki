import 'package:cooki/common/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:cooki/common/component/button/primary_button.dart';
import 'package:cooki/common/theme/app_text_styles.dart';

const _btnDefaultWidth = 150.0;
const _btnDefaultHeight = 35.0;

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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  args.title,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.titleSmall,
                ),
                const SizedBox(height: 16),
                Flexible(
                  child: Text(
                    args.message,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.bodyMedium,
                  ),
                ),
                const SizedBox(height: 32),
                PrimaryButton(
                  label: args.confirmText,
                  onPress: () {
                    Navigator.of(context).pop();
                    args.onConfirm();
                  },
                  height: _btnDefaultHeight,
                  width: _btnDefaultWidth,
                ),
                const SizedBox(height: 8),
                PrimaryButton(
                  label: args.dismissText,
                  backgroundColor: AppColors.backgroundSecondary,
                  onPress: () {
                    Navigator.of(context).pop();
                    args.onCancel?.call();
                  },
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.fontPrimary,
                  ),
                  height: _btnDefaultHeight,
                  width: _btnDefaultWidth,
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
