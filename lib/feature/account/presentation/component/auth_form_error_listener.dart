import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_helper/feature/account/presentation/view_model/auth_view_model.dart';

class AuthFormErrorListener extends StatelessWidget {
  const AuthFormErrorListener({
    required this.onFireAuthException,
    required this.child,
    super.key,
  });

  final void Function(String) onFireAuthException;
  final Widget child;

  void _authErrorListener(
    BuildContext context,
    AuthState state,
  ) {
    if (!state.status.isError) return;
    if (state.error is! FirebaseAuthException) return;

    final fireAuthException = state.error as FirebaseAuthException;

    onFireAuthException(fireAuthException.code);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthViewModel, AuthState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: _authErrorListener,
      child: child,
    );
  }
}
