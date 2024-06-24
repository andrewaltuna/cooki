import 'package:flutter/material.dart';
import 'package:grocery_helper/common/component/app_scaffold.dart';
import 'package:grocery_helper/common/component/custom_form_field.dart';
import 'package:grocery_helper/common/component/primary_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Align(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 350),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Login'),
              CustomFormField(
                label: 'Username',
              ),
              const SizedBox(height: 12),
              CustomFormField(
                label: 'Password',
                obscureText: true,
              ),
              const SizedBox(height: 32),
              PrimaryButton(
                label: 'Login',
                width: double.infinity,
                onPress: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
