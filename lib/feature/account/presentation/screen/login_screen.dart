import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:grocery_helper/common/component/main_scaffold.dart';
import 'package:grocery_helper/feature/account/presentation/component/login_form.dart';
import 'package:grocery_helper/feature/account/presentation/view_model/login_form_errors_view_model.dart';

class LoginScreen extends HookWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();

    return MainScaffold(
      hasNavBar: false,
      alignment: Alignment.center,
      body: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 300),
        child: BlocProvider(
          create: (_) => LoginFormErrorsViewModel(),
          child: LoginForm(
            emailController: emailController,
            passwordController: passwordController,
          ),
        ),
      ),
    );
  }
}
