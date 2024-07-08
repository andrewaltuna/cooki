import 'package:cooki/constant/auth_form_errors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:cooki/common/component/form/custom_form_field.dart';
import 'package:cooki/common/component/button/primary_button.dart';
import 'package:cooki/common/enum/button_state.dart';
import 'package:cooki/common/enum/view_model_status.dart';
import 'package:cooki/common/helper/toast_helper.dart';
import 'package:cooki/common/navigation/app_routes.dart';
import 'package:cooki/feature/account/presentation/component/auth_form_error_listener.dart';
import 'package:cooki/feature/account/presentation/component/auth_redirect_cta.dart';
import 'package:cooki/feature/account/presentation/view_model/auth_view_model.dart';
import 'package:cooki/feature/account/presentation/view_model/login_form_errors_view_model.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    required this.emailController,
    required this.passwordController,
    super.key,
  });

  static final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController;
  final TextEditingController passwordController;

  void _onSubmitted(BuildContext context) {
    FocusScope.of(context).unfocus();

    _formKey.currentState!.validate();

    final isValid = !context.read<LoginFormErrorsViewModel>().state.hasErrors;

    if (!isValid) return;

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
        viewModel.emailError(AuthFormErrors.invalidCredentials);
        break;
      case 'invalid-email':
        viewModel.emailError(AuthFormErrors.invalidEmail);
        break;
      default:
        ToastHelper.of(context).showGenericError();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<LoginFormErrorsViewModel>();

    return AuthFormErrorListener(
      onFireAuthException: (code) => _onFireAuthException(context, code),
      child: BlocBuilder<LoginFormErrorsViewModel, LoginFormErrorsState>(
        builder: (context, state) {
          return Form(
            key: _formKey,
            child: Column(
              children: [
                CustomFormField(
                  controller: emailController,
                  hintText: 'Email',
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  errorText: state.emailError,
                  onChanged: (_) => viewModel.emailError(null),
                  validator: (value) {
                    if (value == '') {
                      viewModel.emailError(AuthFormErrors.emailRequired);
                    }

                    return;
                  },
                ),
                const SizedBox(height: 16),
                CustomFormField(
                  controller: passwordController,
                  hintText: 'Password',
                  icon: Icons.lock_outline_rounded,
                  obscureText: true,
                  textInputAction: TextInputAction.next,
                  errorText: state.passwordError,
                  onChanged: (_) {
                    viewModel.passwordError(null);

                    if (state.emailError == AuthFormErrors.invalidCredentials) {
                      viewModel.emailError(null);
                    }
                  },
                  onSubmitted: (_) => _onSubmitted(context),
                  validator: (value) {
                    if (value == '') {
                      viewModel.passwordError(AuthFormErrors.passwordRequired);
                    }

                    return;
                  },
                ),
                const SizedBox(height: 40),
                BlocSelector<AuthViewModel, AuthState, ViewModelStatus>(
                  selector: (state) => state.status,
                  builder: (context, status) {
                    return PrimaryButton(
                      label: 'Sign In',
                      width: double.infinity,
                      onPress: () => _onSubmitted(context),
                      state: status.isLoading
                          ? ButtonState.loading
                          : ButtonState.idle,
                    );
                  },
                ),
                AuthRedirectCTA(
                  description: "Don't have an account?",
                  label: 'Register',
                  onPress: () => context.go(AppRoutes.registration),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
