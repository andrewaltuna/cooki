import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:grocery_helper/common/component/form/custom_form_field.dart';
import 'package:grocery_helper/common/component/button/primary_button.dart';
import 'package:grocery_helper/common/constants/app_strings.dart';
import 'package:grocery_helper/common/enum/button_state.dart';
import 'package:grocery_helper/common/enum/view_model_status.dart';
import 'package:grocery_helper/common/helper/toast_helper.dart';
import 'package:grocery_helper/common/navigation/app_routes.dart';
import 'package:grocery_helper/feature/account/presentation/component/auth_form_error_listener.dart';
import 'package:grocery_helper/feature/account/presentation/component/auth_redirect_cta.dart';
import 'package:grocery_helper/feature/account/presentation/view_model/auth_view_model.dart';
import 'package:grocery_helper/feature/account/presentation/view_model/reg_form_errors_view_model.dart';
import 'package:grocery_helper/common/theme/app_text_styles.dart';

class RegistrationForm extends StatelessWidget {
  const RegistrationForm({
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    super.key,
  });

  static final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  void _submitForm(BuildContext context) {
    // Trigger local validations, e.g. password match
    _formKey.currentState!.validate();

    final isValid = !context.read<RegFormErrorsViewModel>().state.hasErrors;

    if (isValid) {
      context.read<AuthViewModel>().add(
            AuthRegistered(
              email: emailController.text,
              password: passwordController.text,
            ),
          );

      return;
    }

    // Clear confirm password field if passwords do not match
    if (passwordController.text != confirmPasswordController.text) {
      confirmPasswordController.text = '';
    }
  }

  void _onFireAuthException(
    BuildContext context,
    String code,
  ) {
    final viewModel = context.read<RegFormErrorsViewModel>();

    switch (code) {
      case 'email-already-in-use':
        viewModel.emailError(AppStrings.emailInUse);
        break;
      case 'weak-password':
        viewModel.passwordError(AppStrings.weakPassword);
        break;
      default:
        ToastHelper.of(context).showGenericError();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthFormErrorListener(
      onFireAuthException: (code) => _onFireAuthException(context, code),
      child: BlocBuilder<RegFormErrorsViewModel, RegFormErrorsState>(
        builder: (context, state) {
          return Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Create an account',
                  style: AppTextStyles.title,
                ),
                const SizedBox(height: 40),
                CustomFormField(
                  controller: emailController,
                  hintText: 'Email',
                  icon: Icons.email_outlined,
                  errorText: state.emailError,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  onChanged: (_) =>
                      context.read<RegFormErrorsViewModel>().emailError(null),
                ),
                const SizedBox(height: 16),
                CustomFormField(
                  controller: passwordController,
                  hintText: 'Password',
                  icon: Icons.lock_outline_rounded,
                  obscureText: true,
                  errorText: state.passwordError,
                  textInputAction: TextInputAction.next,
                  onChanged: (_) => context
                      .read<RegFormErrorsViewModel>()
                      .passwordError(null),
                ),
                const SizedBox(height: 16),
                CustomFormField(
                  controller: confirmPasswordController,
                  hintText: 'Confirm password',
                  icon: Icons.lock_outline_rounded,
                  obscureText: true,
                  onChanged: (_) {
                    context
                        .read<RegFormErrorsViewModel>()
                        .confirmPasswordError(null);
                  },
                  errorText: state.confirmPassError,
                  textInputAction: TextInputAction.done,
                  validator: (value) {
                    if (value != passwordController.text) {
                      context
                          .read<RegFormErrorsViewModel>()
                          .confirmPasswordError('Passwords do not match');
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 40),
                BlocSelector<AuthViewModel, AuthState, ViewModelStatus>(
                  selector: (state) => state.status,
                  builder: (context, status) {
                    return PrimaryButton(
                      label: 'Register',
                      width: double.infinity,
                      onPress: () {
                        FocusScope.of(context).unfocus();
                        _submitForm(context);
                      },
                      state: status.isLoading
                          ? ButtonState.loading
                          : ButtonState.idle,
                    );
                  },
                ),
                const SizedBox(height: 16),
                AuthRedirectCTA(
                  description: 'Already have an account?',
                  label: 'Login',
                  onPress: () {
                    context.go(AppRoutes.login);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}