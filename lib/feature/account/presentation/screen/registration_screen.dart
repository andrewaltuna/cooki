import 'package:cooki/feature/account/presentation/component/auth_screen_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:cooki/feature/account/presentation/component/registration_form.dart';
import 'package:cooki/feature/account/presentation/view_model/reg_form_errors_view_model.dart';

class RegistrationScreen extends HookWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = useTextEditingController();
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final confirmPasswordController = useTextEditingController();

    return AuthScreenWrapper(
      title: 'Register',
      description: 'Welcome to Cooki!',
      child: BlocProvider(
        create: (_) => RegFormErrorsViewModel(),
        child: RegistrationForm(
          nameController: nameController,
          emailController: emailController,
          passwordController: passwordController,
          confirmPasswordController: confirmPasswordController,
        ),
      ),
    );
  }
}
