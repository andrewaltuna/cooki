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
    if (state.status.isSuccess) {
      ToastHelper.of(context).showToast('Saved');
    }

    if (state.status.isError) {
      ToastHelper.of(context).showGenericError();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PreferencesViewModel, PreferencesState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: _listener,
      child: child,
    );
  }
}
