import 'package:cooki/common/component/button/primary_button.dart';
import 'package:cooki/common/component/indicator/error_indicator.dart';
import 'package:cooki/common/component/indicator/loading_indicator.dart';
import 'package:cooki/common/component/main_scaffold.dart';
import 'package:cooki/common/enum/view_model_status.dart';
import 'package:cooki/feature/account/presentation/view_model/account_view_model.dart';
import 'package:cooki/feature/account/presentation/view_model/auth_view_model.dart';
import 'package:cooki/feature/preferences/presentation/component/preferences_page_view.dart';
import 'package:cooki/feature/preferences/presentation/view_model/preferences_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PreferencesScreen extends StatelessWidget {
  const PreferencesScreen({super.key});

  void _onSignedOut(BuildContext context) {
    context.read<AuthViewModel>().add(
          const AuthSignedOut(),
        );
    context.read<AccountViewModel>().add(
          const AccountCleared(),
        );
  }

  void _onSaved(BuildContext context) {
    FocusScope.of(context).unfocus();
    context.read<PreferencesViewModel>().add(
          const PreferencesSaved(),
        );
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      title: 'My Preferences',
      contentPadding: EdgeInsets.zero,
      actions: [
        IconButton(
          icon: const Icon(
            Icons.logout_rounded,
          ),
          onPressed: () => _onSignedOut(context),
        ),
      ],
      body: _PreferencesView(
        onSaved: () => _onSaved(context),
      ),
    );
  }
}

class _PreferencesView extends StatelessWidget {
  const _PreferencesView({
    required this.onSaved,
  });

  final VoidCallback onSaved;

  @override
  Widget build(BuildContext context) {
    final status = context.select(
      (PreferencesViewModel viewModel) => viewModel.state.status,
    );

    if (status.isLoading) {
      return const Center(
        child: LoadingIndicator(),
      );
    }

    if (status.isError) {
      return Center(
        child: ErrorIndicator(
          onRetry: () => context.read<PreferencesViewModel>().add(
                const PreferencesRequested(),
              ),
        ),
      );
    }

    return PreferencesPageView(
      footerBuilder: (_, __) {
        return BlocSelector<PreferencesViewModel, PreferencesState,
            ViewModelStatus>(
          selector: (state) => state.submissionStatus,
          builder: (context, submissionStatus) {
            return PrimaryButton(
              label: 'Save',
              isLoading: submissionStatus.isLoading,
              onPress: onSaved,
            );
          },
        );
      },
    );
  }
}
