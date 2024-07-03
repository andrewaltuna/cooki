import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:cooki/common/component/main_scaffold.dart';
import 'package:cooki/feature/account/presentation/component/registration_form.dart';
import 'package:cooki/feature/account/presentation/view_model/reg_form_errors_view_model.dart';

class RegistrationScreen extends HookWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final confirmPasswordController = useTextEditingController();

    return MainScaffold(
      hasNavBar: false,
      alignment: Alignment.center,
      body: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 300),
        child: BlocProvider(
          create: (_) => RegFormErrorsViewModel(),
          child: RegistrationForm(
            emailController: emailController,
            passwordController: passwordController,
            confirmPasswordController: confirmPasswordController,
          ),
        ),
      ),
    );
  }
}
