import 'package:cooki/common/navigation/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({
    super.key,
    this.errorMessage,
    this.path,
  });

  final String? errorMessage;
  final String? path;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline),
            Text(errorMessage ?? 'Something went wrong.'),
            TextButton(
              onPressed: () {
                context.go(path ?? AppRoutes.home);
              },
              child: Text(
                path != null ? 'Go back' : 'Go home',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
