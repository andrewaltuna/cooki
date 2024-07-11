import 'package:cooki/common/component/button/primary_button.dart';
import 'package:cooki/common/enum/button_state.dart';
import 'package:cooki/common/enum/view_model_status.dart';
import 'package:cooki/common/theme/app_text_styles.dart';
import 'package:cooki/feature/account/presentation/view_model/account_view_model.dart';
import 'package:cooki/feature/preferences/presentation/component/preferences_page_view.dart';
import 'package:cooki/feature/preferences/presentation/view_model/preferences_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class PreferencesModalContent extends HookWidget {
  const PreferencesModalContent({super.key});

  void _onNextPressed(PageController controller) {
    controller.nextPage(
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeInOut,
    );
  }

  void _onInitialPreferencesSet(
    BuildContext context, {
    bool isSkip = false,
  }) {
    context.read<AccountViewModel>().add(const AccountInitialPrefsSet());

    if (!isSkip) {
      context.read<PreferencesViewModel>().add(const PreferencesSaved());
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PreferencesViewModel, PreferencesState>(
      listenWhen: (previous, current) =>
          previous.submissionStatus != current.submissionStatus,
      listener: (context, state) {
        // Close modal if submission is successful
        if (state.submissionStatus.isSuccess) {
          Navigator.pop(context);
        }
      },
      child: PreferencesPageView(
        header: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'My Preferences',
              style: AppTextStyles.titleMedium,
            ),
            const SizedBox(height: 24),
          ],
        ),
        footerBuilder: (pageController, isLastPage) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () => _onInitialPreferencesSet(
                  context,
                  isSkip: true,
                ),
                child: Text(
                  'Set up later',
                  style: AppTextStyles.bodyMedium,
                ),
              ),
              BlocSelector<PreferencesViewModel, PreferencesState,
                  ViewModelStatus>(
                selector: (state) => state.submissionStatus,
                builder: (context, status) {
                  return PrimaryButton(
                    label: isLastPage ? 'Finish' : 'Next',
                    height: 30,
                    width: 100,
                    state: status.isLoading
                        ? ButtonState.loading
                        : ButtonState.idle,
                    onPress: () => isLastPage
                        ? _onInitialPreferencesSet(context)
                        : _onNextPressed(pageController),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
