import 'package:cooki/common/component/app_images.dart';
import 'package:cooki/common/component/button/custom_icon_button.dart';
import 'package:cooki/common/component/button/ink_well_button.dart';
import 'package:cooki/common/component/text/flexible_text.dart';
import 'package:cooki/common/hook/use_on_widget_load.dart';
import 'package:cooki/common/theme/app_colors.dart';
import 'package:cooki/common/theme/app_text_styles.dart';
import 'package:cooki/feature/chat/data/enum/certification.dart';
import 'package:cooki/feature/chat/presentation/view_model/bloc/certifications_view_model.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CertificationsPageView extends HookWidget {
  const CertificationsPageView({
    this.title,
    this.certifications,
    this.isElevated = false,
    this.isDense = false,
    super.key,
  });

  final String? title;

  /// Displays all certifications if null.
  final List<Certification>? certifications;
  final bool isElevated;

  /// Does not display badge image in detail view if true.
  final bool isDense;

  @override
  Widget build(BuildContext context) {
    final pageController = usePageController();

    final certifications = this.certifications ?? Certification.values;

    return BlocProvider(
      create: (_) => CertificationsViewModel(),
      child: _PageView(
        title: title,
        certifications: certifications,
        pageController: pageController,
        isElevated: isElevated,
        isDense: isDense,
      ),
    );
  }
}

class _PageView extends HookWidget {
  const _PageView({
    required this.title,
    required this.certifications,
    required this.pageController,
    required this.isElevated,
    required this.isDense,
  });

  final String? title;
  final List<Certification> certifications;
  final PageController pageController;
  final bool isElevated;
  final bool isDense;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CertificationsViewModel>().state;

    useOnWidgetLoad(
      () => pageController.animateToPage(
        state.isDetailView ? 1 : 0,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
      ),
      keys: [state.isDetailView],
    );

    return Container(
      decoration: isElevated
          ? const BoxDecoration(
              color: AppColors.backgroundPrimary,
              borderRadius: BorderRadius.all(Radius.circular(12)),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadow,
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: Offset(0, 2),
                ),
              ],
            )
          : null,
      child: LayoutBuilder(
        builder: (_, constraints) {
          return ExpandablePageView(
            controller: pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: constraints.maxHeight,
                ),
                child: _CertificationsListView(
                  title: title,
                  certifications: certifications,
                  isDense: isDense,
                  onSelected: (certification) => context
                      .read<CertificationsViewModel>()
                      .add(CertificationsSelected(certification)),
                ),
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: constraints.maxHeight,
                ),
                child: _DetailView(
                  certification: state.certification,
                  isDense: isDense,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _CertificationsListView extends StatelessWidget {
  const _CertificationsListView({
    required this.title,
    required this.certifications,
    required this.onSelected,
    required this.isDense,
  });

  final String? title;
  final List<Certification> certifications;
  final void Function(Certification) onSelected;
  final bool isDense;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (title != null) ...[
          _Header(
            title: title!,
          ),
          const SizedBox(height: 8),
        ],
        Flexible(
          child: Scrollbar(
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: certifications.length,
              itemBuilder: (context, index) {
                final certification = certifications[index];

                return InkWellButton(
                  onPressed: () => onSelected(certification),
                  backgroundColor: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        SizedBox(
                          width: isDense ? 35 : 50,
                          child: certification.image.copyWith(height: 40),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            certification.label,
                            style: AppTextStyles.bodyMedium,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(
                          Icons.info_outline,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (_, __) => const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Divider(height: 0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _DetailView extends StatelessWidget {
  const _DetailView({
    required this.certification,
    required this.isDense,
  });

  final Certification certification;
  final bool isDense;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: _DetailHeader(
            title: certification.label,
          ),
        ),
        Flexible(
          child: Scrollbar(
            child: SingleChildScrollView(
              clipBehavior: Clip.none,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!isDense) ...[
                    certification.image.copyWith(height: 100),
                    const SizedBox(height: 16),
                  ],
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: FlexibleText(
                      certification.description,
                      style: AppTextStyles.bodyMedium,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: AppTextStyles.titleSmall,
    );
  }
}

class _DetailHeader extends StatelessWidget {
  const _DetailHeader({
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomIconButton(
          color: AppColors.fontPrimary,
          backgroundColor: Colors.transparent,
          padding: 0,
          icon: Icons.arrow_back,
          onPressed: () => context
              .read<CertificationsViewModel>()
              .add(const CertificationsBackPressed()),
        ),
        Expanded(
          child: _Header(title: title),
        ),
      ],
    );
  }
}
