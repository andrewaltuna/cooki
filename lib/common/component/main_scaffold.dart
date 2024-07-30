import 'package:cooki/common/component/button/app_bar_action_button.dart';
import 'package:cooki/common/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:cooki/common/component/main_navigation_bar.dart';
import 'package:cooki/common/theme/app_text_styles.dart';
import 'package:go_router/go_router.dart';

class MainScaffold extends StatelessWidget {
  const MainScaffold({
    required this.body,
    this.title,
    this.alignment = Alignment.topCenter,
    this.hasNavBar = true,
    this.isScrollable = false,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 12),
    this.backgroundColor,
    this.hasBackButton = false,
    this.actions,
    super.key,
  });

  final String? title;
  final Widget body;
  final Alignment alignment;
  final bool hasNavBar;
  final bool isScrollable;
  final EdgeInsetsGeometry contentPadding;
  final Color? backgroundColor;

  /// Optional actions to be displayed in the app bar. Has no effect if [title] is null.
  final List<Widget>? actions;

  /// Optional action to be displayed on the left of the app bar.
  final bool hasBackButton;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: title != null
            ? AppBar(
                title: Text(
                  title ?? '',
                  style: AppTextStyles.titleMedium,
                ),
                centerTitle: true,
                elevation: 5,
                backgroundColor: AppColors.backgroundPrimary,
                surfaceTintColor: Colors.transparent,
                shadowColor: AppColors.shadow,
                actions: actions,
                leading: hasBackButton
                    ? AppBarActionButton(
                        onPressed: () => context.pop(),
                        icon: Icons.arrow_back,
                      )
                    : null,
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
        backgroundColor: backgroundColor,
        bottomNavigationBar: hasNavBar ? const MainNavigationBar() : null,
      ),
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
