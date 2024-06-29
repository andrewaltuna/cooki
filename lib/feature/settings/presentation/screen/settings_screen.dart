import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_helper/common/component/main_scaffold.dart';
import 'package:grocery_helper/feature/account/presentation/view_model/auth_view_model.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      body: TextButton(
        onPressed: () {
          context.read<AuthViewModel>().add(const AuthSignedOut());
        },
        child: const Text('Sign out'),
      ),
    );
  }
}
