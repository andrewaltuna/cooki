import 'package:cooki/common/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:cooki/common/component/button/primary_button.dart';
import 'package:cooki/common/theme/app_text_styles.dart';

class DialogHelper {
  const DialogHelper(this._context);

  factory DialogHelper.of(BuildContext context) => DialogHelper(context);

  final BuildContext _context;

  static const btnDefaultSize = Size(150.0, 35.0);

  Future<void> showCustomDialog(
    CustomDialogArgs args,
  ) async {
    await showDialog(
      context: _context,
      barrierDismissible: args.barrierDismissable,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: args.contentPadding,
          child: args.builder(context),
        ),
      ),
    );
  }

  Future<void> showDefaultDialog(
    DefaultDialogArgs args,
  ) async {
    await showCustomDialog(
      CustomDialogArgs(
        barrierDismissable: args.barrierDismissable,
        builder: (context) => Column(
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
              height: btnDefaultSize.height,
              width: btnDefaultSize.width,
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
              height: btnDefaultSize.height,
              width: btnDefaultSize.width,
            ),
          ],
        ),
      ),
    );
  }
}

class CustomDialogArgs {
  const CustomDialogArgs({
    required this.builder,
    this.contentPadding = const EdgeInsets.fromLTRB(16, 32, 16, 16),
    this.barrierDismissable = false,
  });

  final Widget Function(BuildContext) builder;
  final EdgeInsetsGeometry contentPadding;
  final bool barrierDismissable;
}

class DefaultDialogArgs {
  const DefaultDialogArgs({
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
