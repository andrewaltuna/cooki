import 'package:cooki/common/helper/dialog_helper.dart';
import 'package:cooki/feature/chat/presentation/component/certifications_dialog_content.dart';
import 'package:cooki/feature/chat/presentation/view_model/bloc/certifications_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatHelper {
  const ChatHelper._(this._context);

  factory ChatHelper.of(BuildContext context) => ChatHelper._(context);

  final BuildContext _context;

  void showCertificationsDialog() {
    DialogHelper.of(_context).showCustomDialog(
      CustomDialogArgs(
        barrierDismissable: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
        builder: (_) => ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 350),
          child: BlocProvider(
            create: (_) => CertificationsViewModel(),
            child: const CertificationsDialogContent(),
          ),
        ),
      ),
    );
  }
}
