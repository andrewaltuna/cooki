import 'package:cooki/common/helper/toast_helper.dart';
import 'package:cooki/feature/preferences/presentation/view_model/preferences_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PreferencesSubmissionHandler extends StatelessWidget {
  const PreferencesSubmissionHandler({
    required this.child,
    super.key,
  });

  final Widget child;

  void _listener(
    BuildContext context,
    PreferencesState state,
  ) {
    if (state.submissionStatus.isSuccess) {
      ToastHelper.of(context).showToast('Saved');
    }

    if (state.submissionStatus.isError) {
      ToastHelper.of(context).showGenericError();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PreferencesViewModel, PreferencesState>(
      listenWhen: (previous, current) =>
          previous.submissionStatus != current.submissionStatus,
      listener: _listener,
      child: child,
    );
  }
}
