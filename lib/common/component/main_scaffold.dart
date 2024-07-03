import 'package:flutter/material.dart';
import 'package:cooki/common/component/main_navigation_bar.dart';
import 'package:cooki/common/theme/app_text_styles.dart';

class MainScaffold extends StatelessWidget {
  const MainScaffold({
    required this.body,
    this.title,
    this.alignment = Alignment.topCenter,
    this.hasNavBar = true,
    super.key,
  });

  final String? title;
  final Widget body;
  final Alignment alignment;
  final bool hasNavBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: title != null
          ? AppBar(
              title: Text(
                title ?? '',
                style: AppTextStyles.title,
              ),
              centerTitle: true,
            )
          : null,
      body: SafeArea(
        child: Align(
          alignment: alignment,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: body,
            ),
          ),
        ),
      ),
      bottomNavigationBar: hasNavBar ? const MainNavigationBar() : null,
    );
  }
}
