import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_helper/common/component/main_scaffold.dart';
import 'package:grocery_helper/feature/account/presentation/view_model/auth_view_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      body: Column(
        children: [
          TextButton(
            onPressed: () {
              context.read<AuthViewModel>().add(const AuthSignedOut());
            },
            child: const Text('Sign out'),
          ),
        ],
      ),
    );
  }
}
