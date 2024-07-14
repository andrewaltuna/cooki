import 'package:cooki/common/component/button/primary_button.dart';
import 'package:cooki/common/component/main_scaffold.dart';
import 'package:cooki/common/enum/button_state.dart';
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
      body: PreferencesPageView(
        footerBuilder: (_, __) {
          return BlocSelector<PreferencesViewModel, PreferencesState,
              ViewModelStatus>(
            selector: (state) => state.submissionStatus,
            builder: (context, submissionStatus) {
              return PrimaryButton(
                label: 'Save',
                state: submissionStatus.isLoading
                    ? ButtonState.loading
                    : ButtonState.idle,
                onPress: () => _onSaved(context),
              );
            },
          );
        },
      ),
    );
  }
}
