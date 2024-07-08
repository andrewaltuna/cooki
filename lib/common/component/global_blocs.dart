import 'package:cooki/feature/account/data/di/account_service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cooki/feature/account/data/di/auth_service_locator.dart';
import 'package:cooki/feature/account/presentation/view_model/auth_view_model.dart';

/// Globally provided blocs regardless of navigation route.
class GlobalBlocs extends StatelessWidget {
  const GlobalBlocs({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthViewModel(authRepository, accountRepository)
            ..add(
              const AuthStreamInitialized(),
            ),
        ),
      ],
      child: child,
    );
  }
}
