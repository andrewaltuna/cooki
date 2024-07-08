import 'package:cooki/feature/account/presentation/component/auth_screen_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:cooki/feature/account/presentation/component/login_form.dart';
import 'package:cooki/feature/account/presentation/view_model/login_form_errors_view_model.dart';

class LoginScreen extends HookWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();

    return AuthScreenWrapper(
      title: 'Sign in',
      description: 'Glad to have you back!',
      child: BlocProvider(
        create: (_) => LoginFormErrorsViewModel(),
        child: LoginForm(
          emailController: emailController,
          passwordController: passwordController,
        ),
      ),
    );
  }
}
