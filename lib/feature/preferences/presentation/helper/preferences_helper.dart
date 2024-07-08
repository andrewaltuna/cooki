import 'package:cooki/common/theme/app_colors.dart';
import 'package:cooki/feature/account/presentation/view_model/account_view_model.dart';
import 'package:cooki/feature/preferences/data/di/preferences_service_locator.dart';
import 'package:cooki/feature/preferences/presentation/component/preferences_modal_content.dart';
import 'package:cooki/feature/preferences/presentation/view_model/preferences_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PreferencesHelper {
  const PreferencesHelper._(this._context);

  factory PreferencesHelper.of(BuildContext context) =>
      PreferencesHelper._(context);

  final BuildContext _context;

  void showPreferencesModal() async {
    await showDialog(
      context: _context,
      barrierDismissible: false,
      builder: (_) {
        return PopScope(
          canPop: false,
          child: MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: BlocProvider.of<AccountViewModel>(_context),
              ),
              BlocProvider(
                create: (_) => PreferencesViewModel(preferencesRepository),
              ),
            ],
            child: const Dialog(
              backgroundColor: AppColors.backgroundPrimary,
              insetPadding: EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              child: PreferencesModalContent(),
            ),
          ),
        );
      },
    );
  }
}
