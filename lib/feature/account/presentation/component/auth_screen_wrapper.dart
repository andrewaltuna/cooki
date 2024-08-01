import 'package:cooki/common/component/main_scaffold.dart';
import 'package:cooki/common/theme/app_colors.dart';
import 'package:cooki/common/theme/app_text_styles.dart';
import 'package:flutter/widgets.dart';

const _formHorizontalPadding = EdgeInsets.symmetric(horizontal: 24);

class AuthScreenWrapper extends StatelessWidget {
  const AuthScreenWrapper({
    required this.title,
    required this.description,
    required this.child,
    super.key,
  });

  final String title;
  final String description;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      contentPadding: EdgeInsets.zero,
      backgroundColor: AppColors.accent,
      hasNavBar: false,
      alignment: Alignment.center,
      isScrollable: false,
      body: Column(
        children: [
          Container(
            height: 200,
            alignment: Alignment.center,
            child: Image.asset(
              'assets/imgs/logo_alt.png',
              height: 150,
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: _formHorizontalPadding,
              decoration: const BoxDecoration(
                color: AppColors.backgroundPrimary,
                borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              ),
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 300),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 32),
                      Text(
                        title,
                        style: AppTextStyles.titleLarge,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        description,
                        style: AppTextStyles.bodyLarge,
                      ),
                      const SizedBox(height: 32),
                      child,
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
