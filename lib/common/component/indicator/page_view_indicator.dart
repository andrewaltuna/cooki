import 'package:cooki/common/theme/app_colors.dart';
import 'package:flutter/material.dart';

const _indicatorSize = 10.0;

class PageViewIndicator extends StatelessWidget {
  const PageViewIndicator({
    required this.pageCount,
    required this.currentPageIndex,
    super.key,
  });

  final int pageCount;
  final int currentPageIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(pageCount, (index) {
        final isSelected = index == currentPageIndex;

        return AnimatedContainer(
          height: _indicatorSize,
          width: isSelected ? _indicatorSize * 2 : _indicatorSize,
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeInOut,
          margin: const EdgeInsets.symmetric(horizontal: 3),
          decoration: BoxDecoration(
            color:
                isSelected ? AppColors.accent : AppColors.backgroundSecondary,
            borderRadius: BorderRadius.circular(50),
          ),
        );
      }),
    );
  }
}
