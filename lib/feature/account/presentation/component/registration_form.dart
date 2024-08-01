import 'package:cooki/constant/auth_form_errors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:cooki/common/component/form/custom_form_field.dart';
import 'package:cooki/common/component/button/primary_button.dart';
import 'package:cooki/common/enum/view_model_status.dart';
import 'package:cooki/common/helper/toast_helper.dart';
import 'package:cooki/common/navigation/app_routes.dart';
import 'package:cooki/feature/account/presentation/component/auth_form_error_listener.dart';
import 'package:cooki/feature/account/presentation/component/auth_redirect_cta.dart';
import 'package:cooki/feature/account/presentation/view_model/auth_view_model.dart';
import 'package:cooki/feature/account/presentation/view_model/reg_form_errors_view_model.dart';

class RegistrationForm extends StatelessWidget {
  const RegistrationForm({
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    super.key,
  });

  static final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  void _onSubmited(BuildContext context) {
    FocusScope.of(context).unfocus();

    // Trigger local validations, e.g. password match
    _formKey.currentState!.validate();

    final isValid = !context.read<RegFormErrorsViewModel>().state.hasErrors;

    if (isValid) {
      context.read<AuthViewModel>().add(
            AuthUserCreated(
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
        viewModel.emailError(AuthFormErrors.emailInUse);
        break;
      case 'weak-password':
        viewModel.passwordError(AuthFormErrors.weakPassword);
        break;
      default:
        ToastHelper.of(context).showGenericError();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<RegFormErrorsViewModel>();

    return AuthFormErrorListener(
      onFireAuthException: (code) => _onFireAuthException(context, code),
      child: BlocBuilder<RegFormErrorsViewModel, RegFormErrorsState>(
        builder: (context, state) {
          return Form(
            key: _formKey,
            child: Column(
              children: [
                CustomFormField(
                  controller: emailController,
                  hintText: 'Email',
                  icon: Icons.email_outlined,
                  errorText: state.emailError,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
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
                  errorText: state.passwordError,
                  textInputAction: TextInputAction.next,
                  onChanged: (_) => viewModel.passwordError(null),
                  validator: (value) {
                    if (value == '') {
                      viewModel.passwordError(AuthFormErrors.passwordRequired);
                    }

                    return;
                  },
                ),
                const SizedBox(height: 16),
                CustomFormField(
                  controller: confirmPasswordController,
                  hintText: 'Confirm password',
                  icon: Icons.lock_outline_rounded,
                  obscureText: true,
                  onChanged: (_) => viewModel.confirmPasswordError(null),
                  errorText: state.confirmPassError,
                  textInputAction: TextInputAction.done,
                  validator: (value) {
                    if (value != passwordController.text) {
                      viewModel.confirmPasswordError(
                        AuthFormErrors.passwordMismatch,
                      );
                    }

                    return;
                  },
                ),
                const SizedBox(height: 40),
                BlocSelector<AuthViewModel, AuthState, ViewModelStatus>(
                  selector: (state) => state.status,
                  builder: (context, status) {
                    return PrimaryButton(
                      label: 'Proceed',
                      width: double.infinity,
                      onPress: () => _onSubmited(context),
                      isLoading: status.isLoading,
                    );
                  },
                ),
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
