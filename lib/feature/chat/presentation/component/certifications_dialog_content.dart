import 'package:cooki/common/component/app_images.dart';
import 'package:cooki/common/component/button/custom_icon_button.dart';
import 'package:cooki/common/component/button/ink_well_button.dart';
import 'package:cooki/common/hook/use_on_widget_load.dart';
import 'package:cooki/common/theme/app_colors.dart';
import 'package:cooki/common/theme/app_text_styles.dart';
import 'package:cooki/feature/chat/data/enum/certification.dart';
import 'package:cooki/feature/chat/presentation/view_model/bloc/certifications_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CertificationsDialogContent extends HookWidget {
  const CertificationsDialogContent({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CertificationsViewModel>().state;
    final pageController = usePageController();
    final scrollController = useScrollController();

    useOnWidgetLoad(
      () => pageController.animateToPage(
        state.isDetailView ? 1 : 0,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
      ),
      keys: [state.isDetailView],
    );

    return Column(
      children: [
        if (!state.isDetailView)
          const _Header(
            title: 'Our Sustainability Badges',
          )
        else
          _DetailHeader(
            title: state.certification.label,
          ),
        const SizedBox(height: 8),
        Expanded(
          child: PageView(
            controller: pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              _CertificationsListView(
                controller: scrollController,
                onSelected: (certification) => context
                    .read<CertificationsViewModel>()
                    .add(CertificationsSelected(certification)),
              ),
              _DetailView(
                certification: state.certification,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _DetailView extends StatelessWidget {
  const _DetailView({
    required this.certification,
  });

  final Certification certification;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        certification.image.copyWith(height: 100),
        const SizedBox(height: 8),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                certification.description,
                style: AppTextStyles.bodyMedium,
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

class _CertificationsListView extends StatelessWidget {
  const _CertificationsListView({
    required this.controller,
    required this.onSelected,
  });

  static const _certifications = Certification.values;

  final ScrollController controller;
  final void Function(Certification) onSelected;

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: ListView.separated(
        controller: controller,
        itemCount: _certifications.length,
        itemBuilder: (context, index) {
          final certification = _certifications[index];

          return InkWellButton(
            onPressed: () => onSelected(certification),
            backgroundColor: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  SizedBox(
                    width: 50,
                    child: certification.image.copyWith(height: 40),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      certification.label,
                      style: AppTextStyles.titleVerySmall,
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
        separatorBuilder: (context, index) {
          final isLastItem = index == _certifications.length - 1;

          if (!isLastItem) {
            return const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Divider(height: 0),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
