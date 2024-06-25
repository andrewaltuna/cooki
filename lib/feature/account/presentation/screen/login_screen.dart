import 'package:flutter/material.dart';
import 'package:grocery_helper/common/component/app_scaffold.dart';
import 'package:grocery_helper/common/component/custom_form_field.dart';
import 'package:grocery_helper/common/component/primary_button.dart';
import 'package:grocery_helper/feature/account/presentation/component/auth_redirect_cta.dart';
import 'package:grocery_helper/theme/app_text_style.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Align(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 350),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Login',
                  style: AppTextStyle.title,
                ),
                const SizedBox(height: 32),
                CustomFormField(
                  label: 'Email',
                ),
                const SizedBox(height: 16),
                CustomFormField(
                  label: 'Password',
                  obscureText: true,
                ),
                const SizedBox(height: 40),
                PrimaryButton(
                  label: 'Sign In',
                  width: double.infinity,
                  onPress: () {},
                ),
                const SizedBox(height: 16),
                AuthRedirectCTA(
                  description: "Don't have an account?",
                  label: 'Register',
                  onPress: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
