import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grocery_helper/common/constants/app_strings.dart';
import 'package:grocery_helper/common/theme/app_colors.dart';

class ToastHelper {
  const ToastHelper._(this._context);

  factory ToastHelper.of(BuildContext context) => ToastHelper._(context);

  final BuildContext _context;

  void show(
    String message, {
    bool dismissable = true,
    bool clearQueue = true,
  }) {
    final fToast = FToast()..init(_context);

    if (clearQueue) fToast.removeQueuedCustomToasts();

    final toast = Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 12.0,
      ),
      decoration: const BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Text(
        message,
        style: const TextStyle(
          color: AppColors.fontSecondary,
        ),
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.TOP,
      isDismissable: dismissable,
    );
  }

  void showGenericError() => show(AppStrings.errorGeneric);
}
