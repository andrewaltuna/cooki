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
        child: Container(
          padding: args.contentPadding,
          constraints: args.constraints,
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
              style: AppTextStyles.titleMedium,
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
              backgroundColor: switch (args.primaryActionType) {
                DefaultDialogAction.confirm => AppColors.accent,
                DefaultDialogAction.warning => AppColors.fontWarning,
              },
            ),
            const SizedBox(height: 8),
            PrimaryButton(
              label: args.dismissText,
              onPress: () {
                Navigator.of(context).pop();
                args.onCancel?.call();
              },
              labelColor: AppColors.fontPrimary,
              backgroundColor: AppColors.backgroundSecondary,
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
    this.contentPadding = const EdgeInsets.fromLTRB(16, 24, 16, 16),
    this.barrierDismissable = false,
    this.constraints,
  });

  final Widget Function(BuildContext) builder;
  final EdgeInsetsGeometry contentPadding;
  final bool barrierDismissable;
  final BoxConstraints? constraints;
}

class DefaultDialogArgs {
  const DefaultDialogArgs({
    required this.title,
    required this.message,
    required this.onConfirm,
    this.confirmText = 'Confirm',
    this.dismissText = 'Dismiss',
    this.onCancel,
    this.primaryActionType = DefaultDialogAction.confirm,
    this.barrierDismissable = false,
  });

  final String title;
  final String message;
  final String confirmText;
  final String dismissText;
  final VoidCallback onConfirm;
  final VoidCallback? onCancel;
  final DefaultDialogAction primaryActionType;
  final bool barrierDismissable;
}

enum DefaultDialogAction {
  confirm,
  warning;
}
