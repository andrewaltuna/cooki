import 'package:cooki/common/component/indicator/page_view_indicator.dart';
import 'package:cooki/common/component/labeled_checkbox.dart';
import 'package:cooki/common/hook/use_on_widget_load.dart';
import 'package:cooki/common/theme/app_text_styles.dart';
import 'package:cooki/feature/preferences/presentation/component/preferences_dietary_restrictions_page.dart';
import 'package:cooki/feature/preferences/presentation/component/preferences_medications_page.dart';
import 'package:cooki/feature/preferences/presentation/component/preferences_product_categories_page.dart';
import 'package:cooki/feature/preferences/presentation/component/preferences_submission_handler.dart';
import 'package:cooki/feature/preferences/presentation/view_model/preferences_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

const _numPages = 4;
const _contentPadding = 24.0;

class PreferencesPageView extends HookWidget {
  const PreferencesPageView({
    this.header,
    this.footerBuilder,
    super.key,
  });

  final Widget? header;
  final Widget Function(PageController, bool)? footerBuilder;

  void _listener(
    BuildContext context,
    ValueNotifier<int> pageNotifier,
    PageController pageController,
  ) {
    final currentPage = pageController.page?.round() ?? 0;

    if (pageNotifier.value == currentPage) return;

    if (FocusScope.of(context).hasFocus) {
      FocusScope.of(context).unfocus();
    }

    pageNotifier.value = currentPage;
  }

  @override
  Widget build(BuildContext context) {
    final pageIndexNotifier = useState(0);
    final pageController = usePageController();

    final isLastPage = pageIndexNotifier.value == _numPages - 1;

    useOnWidgetLoad(
      () => pageController.addListener(
        () => _listener(context, pageIndexNotifier, pageController),
      ),
      cleanup: () => pageController.removeListener(
        () => _listener(context, pageIndexNotifier, pageController),
      ),
    );

    return PreferencesSubmissionHandler(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: _contentPadding),
        child: Column(
          children: [
            if (header != null) header ?? const SizedBox.shrink(),
            Expanded(
              child: BlocBuilder<PreferencesViewModel, PreferencesState>(
                builder: (context, state) {
                  return PageView(
                    controller: pageController,
                    children: [
                      PreferencesProductCategoriesPage(
                        items: state.productCategories,
                      ),
                      PreferencesDietaryRestrictionsPage(
                        items: state.dietaryRestrictions,
                      ),
                      PreferencesMedicationsPage(
                        items: state.medications,
                      ),
                      const _NotificationsSection(),
                    ].map((page) => _PagePadding(child: page)).toList(),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: _contentPadding,
              ),
              child: Column(
                children: [
                  PageViewIndicator(
                    pageCount: _numPages,
                    currentPageIndex: pageIndexNotifier.value,
                  ),
                  if (footerBuilder != null) ...[
                    const SizedBox(height: 20),
                    footerBuilder?.call(
                          pageController,
                          isLastPage,
                        ) ??
                        const SizedBox.shrink(),
                  ]
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NotificationsSection extends StatelessWidget {
  const _NotificationsSection();

  @override
  Widget build(BuildContext context) {
    final promoNotifications = context.select(
      (PreferencesViewModel viewModel) => viewModel.state.promoNotifications,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Notifications',
          style: AppTextStyles.titleSmall,
        ),
        LabeledCheckbox(
          label: 'Special offers and promotions',
          value: promoNotifications,
          onChanged: (_) => context.read<PreferencesViewModel>().add(
                const PreferencesPromoNotificationsToggled(),
              ),
        ),
      ],
    );
  }
}

class _PagePadding extends StatelessWidget {
  const _PagePadding({
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: _contentPadding),
      child: child,
    );
  }
}
