import 'package:cooki/common/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cooki/common/extension/context_route.dart';
import 'package:cooki/common/navigation/app_routes.dart';
import 'package:cooki/common/theme/app_colors.dart';
import 'package:ionicons/ionicons.dart';

class MainNavigationBar extends StatelessWidget {
  const MainNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: const BoxDecoration(
        color: AppColors.backgroundPrimary,
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            spreadRadius: 1,
            blurRadius: 7,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          _MainNavBarItem(
            label: 'Home',
            location: AppRoutes.home,
            icon: Ionicons.home_outline,
            selectedIcon: Ionicons.home,
            isSelected: context.isHomeRoute,
          ),
          _MainNavBarItem(
            label: 'List',
            location: AppRoutes.shoppingLists,
            icon: Ionicons.cart_outline,
            selectedIcon: Ionicons.cart,
            isSelected: context.isShoppingListRoute,
          ),
          _MainNavBarItem(
            label: 'Explore',
            location: AppRoutes.map,
            icon: Ionicons.compass_outline,
            selectedIcon: Ionicons.compass,
            isSelected: context.isMapRoute,
          ),
          _MainNavBarItem(
            label: 'Account',
            location: AppRoutes.settings,
            icon: Ionicons.person_circle_outline,
            selectedIcon: Ionicons.person_circle,
            isSelected: context.isSettingsRoute,
          ),
        ],
      ),
    );
  }
}

class _MainNavBarItem extends StatelessWidget {
  const _MainNavBarItem({
    required this.label,
    required this.location,
    required this.icon,
    required this.selectedIcon,
    required this.isSelected,
  });

  final String label;
  final String location;
  final IconData icon;
  final IconData selectedIcon;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? AppColors.accent : AppColors.primary;
    final fontWeight = isSelected ? FontWeight.bold : FontWeight.normal;

    return Expanded(
      child: GestureDetector(
        onTap: () => context.go(location),
        behavior: HitTestBehavior.translucent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isSelected ? selectedIcon : icon,
              size: 20,
              color: color,
            ),
            Text(
              label,
              style: AppTextStyles.bodyMedium.copyWith(
                color: color,
                fontWeight: fontWeight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
