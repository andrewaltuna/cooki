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
import 'package:grocery_helper/feature/account/presentation/view_model/login_form_errors_view_model.dart';
import 'package:grocery_helper/common/theme/app_text_styles.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    required this.emailController,
    required this.passwordController,
    super.key,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;

  void _submitForm(BuildContext context) {
    context.read<AuthViewModel>().add(
          AuthSignedIn(
            email: emailController.text,
            password: passwordController.text,
          ),
        );
  }

  void _onFireAuthException(
    BuildContext context,
    String code,
  ) {
    final viewModel = context.read<LoginFormErrorsViewModel>();

    switch (code) {
      case 'invalid-credential':
        viewModel.emailError(AppStrings.invalidCredentials);
        break;
      case 'invalid-email':
        viewModel.emailError(AppStrings.invalidEmail);
        break;
      default:
        ToastHelper.of(context).showGenericError();
        break;
    }
  }

  void _onEmailChanged(BuildContext context) =>
      context.read<LoginFormErrorsViewModel>().emailError(null);

  void _onPasswordChanged(
    BuildContext context,
    String? emailError,
  ) {
    context.read<LoginFormErrorsViewModel>().passwordError(null);

    if (emailError == AppStrings.invalidCredentials) {
      context.read<LoginFormErrorsViewModel>().emailError(null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthFormErrorListener(
      onFireAuthException: (code) => _onFireAuthException(context, code),
      child: BlocBuilder<LoginFormErrorsViewModel, LoginFormErrorsState>(
        builder: (context, state) {
          return Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Login',
                  style: AppTextStyles.title,
                ),
                const SizedBox(height: 32),
                CustomFormField(
                  controller: emailController,
                  hintText: 'Email',
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  errorText: state.emailError,
                  onChanged: (_) => _onEmailChanged(context),
                ),
                const SizedBox(height: 16),
                CustomFormField(
                  controller: passwordController,
                  hintText: 'Password',
                  icon: Icons.lock_outline_rounded,
                  obscureText: true,
                  textInputAction: TextInputAction.next,
                  errorText: state.passwordError,
                  onChanged: (_) => _onPasswordChanged(
                    context,
                    state.emailError,
                  ),
                ),
                const SizedBox(height: 40),
                BlocSelector<AuthViewModel, AuthState, ViewModelStatus>(
                  selector: (state) => state.status,
                  builder: (context, status) {
                    return PrimaryButton(
                      label: 'Sign In',
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
                  description: "Don't have an account?",
                  label: 'Register',
                  onPress: () {
                    context.go(AppRoutes.registration);
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
