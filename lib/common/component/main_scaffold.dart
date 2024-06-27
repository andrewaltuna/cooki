import 'package:flutter/material.dart';
import 'package:grocery_helper/common/component/main_navigation_bar.dart';

class MainScaffold extends StatelessWidget {
  const MainScaffold({
    required this.body,
    this.title,
    super.key,
  });

  final String? title;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: title != null
          ? AppBar(
              title: Text(title ?? ''),
            )
          : null,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Align(
            child: SingleChildScrollView(
              child: body,
            ),
          ),
        ),
      ),
      bottomNavigationBar: const MainNavigationBar(),
    );
  }
}
