import 'package:flutter/material.dart';

class DialogShell extends StatelessWidget {
  const DialogShell({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
        child: child,
      ),
    );
  }
}
