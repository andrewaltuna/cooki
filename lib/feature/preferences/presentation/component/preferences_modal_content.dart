import 'package:cooki/common/component/button/primary_button.dart';
import 'package:cooki/common/component/indicator/page_view_indicator.dart';
import 'package:cooki/common/component/labeled_checkbox.dart';
import 'package:cooki/common/enum/button_state.dart';
import 'package:cooki/common/enum/view_model_status.dart';
import 'package:cooki/common/hook/use_on_widget_load.dart';
import 'package:cooki/common/theme/app_text_styles.dart';
import 'package:cooki/feature/account/presentation/view_model/account_view_model.dart';
import 'package:cooki/feature/preferences/data/enum/dietary_restriction.dart';
import 'package:cooki/feature/preferences/data/enum/product_category.dart';
import 'package:cooki/feature/preferences/presentation/component/preferences_selectable_item.dart';
import 'package:cooki/feature/preferences/presentation/component/preferences_selectable_section.dart';
import 'package:cooki/feature/preferences/presentation/component/preferences_submission_handler.dart';
import 'package:cooki/feature/preferences/presentation/view_model/preferences_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

const _contentPadding = 24.0;

class PreferencesModalContent extends HookWidget {
  const PreferencesModalContent({super.key});

  void _listener(
    ValueNotifier<int> pageNotifier,
    PageController pageController,
  ) {
    pageNotifier.value = pageController.page?.round() ?? 0;
  }

  void _onNextPressed(PageController controller) {
    controller.nextPage(
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeInOut,
    );
  }

  void _onInitialPreferencesSet(
    BuildContext context, {
    bool isSkip = false,
  }) {
    if (!isSkip) {
      context.read<PreferencesViewModel>().add(
            const PreferencesSaved(),
          );
    }

    context.read<AccountViewModel>().add(
          const AccountInitialPrefsSet(),
        );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    const pages = [
      _ProductCategoriesPage(),
      _DietaryRestrictionsPage(),
    ];
    final pageNotifier = useState(0);
    final pageController = usePageController();

    final isLastPage = pageNotifier.value == pages.length - 1;

    useOnWidgetLoad(
      () => pageController.addListener(
        () => _listener(pageNotifier, pageController),
      ),
      cleanup: () => pageController.removeListener(
        () => _listener(pageNotifier, pageController),
      ),
    );

    return PreferencesSubmissionHandler(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: _contentPadding),
        child: Column(
          children: [
            Text(
              'My Preferences',
              style: AppTextStyles.titleMedium,
            ),
            const SizedBox(height: 24),
            Expanded(
              child: PageView(
                controller: pageController,
                children: pages
                    .map(
                      (page) => _PagePadding(child: page),
                    )
                    .toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: _contentPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(),
                  const SizedBox(height: 12),
                  Text(
                    'Notifications',
                    style: AppTextStyles.titleSmall,
                  ),
                  LabeledCheckbox(
                    label: 'Get notified about new products',
                    value: true,
                    onChanged: (_) {},
                  ),
                  LabeledCheckbox(
                    label: 'Get notified about special offers and promotions',
                    value: false,
                    onChanged: (_) {},
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () => _onInitialPreferencesSet(
                          context,
                          isSkip: true,
                        ),
                        child: Text(
                          'Set up later',
                          style: AppTextStyles.bodyMedium,
                        ),
                      ),
                      PageViewIndicator(
                        pageCount: pages.length,
                        currentPageIndex: pageNotifier.value,
                      ),
                      BlocSelector<PreferencesViewModel, PreferencesState,
                          ViewModelStatus>(
                        selector: (state) => state.status,
                        builder: (context, status) {
                          return PrimaryButton(
                            label: isLastPage ? 'Finish' : 'Next',
                            height: 30,
                            width: 100,
                            state: status.isLoading
                                ? ButtonState.loading
                                : ButtonState.idle,
                            onPress: () => isLastPage
                                ? _onInitialPreferencesSet(context)
                                : _onNextPressed(pageController),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
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
      padding: const EdgeInsets.only(left: _contentPadding),
      child: child,
    );
  }
}

class _ProductCategoriesPage extends StatelessWidget {
  const _ProductCategoriesPage();

  static const _categories = ProductCategory.values;

  @override
  Widget build(BuildContext context) {
    final selectedCategories = context.select(
      (PreferencesViewModel viewModel) => viewModel.state.productCategories,
    );

    return PreferencesSelectableSection(
      label: 'Product Categories',
      description: 'Select your favorite product categories',
      builder: (index) {
        final category = _categories[index];

        final isSelected = selectedCategories.contains(category);

        return PreferencesSelectableItem(
          isSelected: isSelected,
          label: category.displayLabel,
          icon: category.icon,
          onSelected: () => context.read<PreferencesViewModel>().add(
                PreferencesProductCategorySelected(category),
              ),
        );
      },
      itemCount: _categories.length,
    );
  }
}

class _DietaryRestrictionsPage extends StatelessWidget {
  const _DietaryRestrictionsPage();

  static const _restrictions = DietaryRestriction.values;

  @override
  Widget build(BuildContext context) {
    final selectedRestrictions = context.select(
      (PreferencesViewModel viewModel) => viewModel.state.dietaryRestrictions,
    );

    return PreferencesSelectableSection(
      label: 'Dietary Restrictions',
      description: 'Select any dietary restrictions you may have',
      builder: (index) {
        final restriction = _restrictions[index];

        final isSelected = selectedRestrictions.contains(restriction);

        return PreferencesSelectableItem(
          isSelected: isSelected,
          label: restriction.displayLabel,
          icon: restriction.icon,
          onSelected: () => context.read<PreferencesViewModel>().add(
                PreferencesDietaryRestrictionSelected(restriction),
              ),
        );
      },
      itemCount: _restrictions.length,
    );
  }
}
