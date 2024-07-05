import 'package:flutter/material.dart';
import 'package:cooki/common/component/main_navigation_bar.dart';
import 'package:cooki/common/theme/app_text_styles.dart';

class MainScaffold extends StatelessWidget {
  const MainScaffold({
    required this.body,
    this.title,
    this.alignment = Alignment.topCenter,
    this.hasNavBar = true,
    this.isScrollable = false,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 12),
    super.key,
  });

  final String? title;
  final Widget body;
  final Alignment alignment;
  final bool hasNavBar;
  final bool isScrollable;
  final EdgeInsetsGeometry contentPadding;

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
          child: _OptionalScrollView(
            isScrollable: isScrollable,
            child: Padding(
              padding: contentPadding,
              child: body,
            ),
          ),
        ),
      ),
      bottomNavigationBar: hasNavBar ? const MainNavigationBar() : null,
    );
  }
}

class _OptionalScrollView extends StatelessWidget {
  const _OptionalScrollView({
    required this.isScrollable,
    required this.child,
  });

  final bool isScrollable;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (!isScrollable) return child;

    return SingleChildScrollView(
      child: child,
    );
  }
}
