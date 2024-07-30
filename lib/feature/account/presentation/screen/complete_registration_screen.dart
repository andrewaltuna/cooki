import 'package:cooki/feature/account/presentation/component/auth_screen_wrapper.dart';
import 'package:cooki/feature/account/presentation/component/complete_registration_form.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CompleteRegistrationScreen extends HookWidget {
  const CompleteRegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();

    return AuthScreenWrapper(
      title: 'Create a nickname',
      description: 'Choose a nickname to get started!',
      child: CompleteRegistrationForm(
        controller: controller,
      ),
    );
  }
}
