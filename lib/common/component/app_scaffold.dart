import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    required this.body,
    this.title,
    super.key,
  });

  final String? title;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: title != null
            ? AppBar(
                title: Text(title ?? ''),
              )
            : null,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Align(
            child: body,
          ),
        ),
      ),
    );
  }
}
