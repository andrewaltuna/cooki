import 'package:cooki/common/component/button/primary_button.dart';
import 'package:cooki/common/component/form/custom_form_field.dart';
import 'package:cooki/common/enum/button_state.dart';
import 'package:cooki/common/enum/view_model_status.dart';
import 'package:cooki/common/helper/input_formatter/name_case_input_formatter.dart';
import 'package:cooki/constant/auth_form_errors.dart';
import 'package:cooki/feature/account/presentation/view_model/account_view_model.dart';
import 'package:cooki/feature/account/presentation/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CompleteRegistrationForm extends StatelessWidget {
  const CompleteRegistrationForm({
    required this.controller,
    super.key,
  });

  static final _formKey = GlobalKey<FormState>();

  final TextEditingController controller;

  void _registrationSuccessListener(
    BuildContext context,
    AccountState _,
  ) {
    context.read<AuthViewModel>().add(
          const AuthRegistrationStatusUpdated(),
        );
  }

  void _onSubmitted(BuildContext context) {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) return;

    context.read<AccountViewModel>().add(
          AccountRegistered(controller.text),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AccountViewModel, AccountState>(
      listenWhen: (previous, current) =>
          previous.user.isEmpty && current.user.isNotEmpty,
      listener: _registrationSuccessListener,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            CustomFormField(
              controller: controller,
              hintText: 'Nickname',
              icon: Icons.account_circle_outlined,
              textInputAction: TextInputAction.next,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == '') {
                  return AuthFormErrors.nameRequired;
                }

                return null;
              },
              textCapitalization: TextCapitalization.words,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')),
                NameCaseInputFormatter(),
              ],
            ),
            const SizedBox(height: 40),
            BlocSelector<AccountViewModel, AccountState, ViewModelStatus>(
              selector: (state) => state.status,
              builder: (context, status) {
                return PrimaryButton(
                  label: 'Complete',
                  width: double.infinity,
                  onPress: () => _onSubmitted(context),
                  state:
                      status.isLoading ? ButtonState.loading : ButtonState.idle,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
