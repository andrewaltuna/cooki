import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_helper/feature/account/data/di/auth_service_locator.dart';
import 'package:grocery_helper/feature/account/presentation/view_model/auth_view_model.dart';

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
          create: (_) => AuthViewModel(authRepository)
            ..add(
              const AuthStreamInitialized(),
            ),
        ),
      ],
      child: child,
    );
  }
}
