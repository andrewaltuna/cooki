import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grocery_helper/common/extension/context_route.dart';
import 'package:grocery_helper/common/navigation/app_routes.dart';
import 'package:grocery_helper/common/theme/app_colors.dart';
import 'package:ionicons/ionicons.dart';

class MainNavigationBar extends StatelessWidget {
  const MainNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: AppColors.accent,
          borderRadius: BorderRadius.circular(50),
          boxShadow: const [
            BoxShadow(
              color: AppColors.shadow,
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _MainNavBarItem(
              label: 'Home',
              icon: Ionicons.home_outline,
              selectedIcon: Ionicons.home,
              isSelected: context.isHomeRoute,
              onPressed: () => context.go(AppRoutes.home),
            ),
            _MainNavBarItem(
              label: 'Shopping List',
              icon: Ionicons.cart_outline,
              selectedIcon: Ionicons.cart,
              isSelected: context.isShoppingListRoute,
              onPressed: () => context.go(AppRoutes.shoppingList),
            ),
            _MainNavBarItem(
              label: 'Settings',
              icon: Ionicons.settings_outline,
              selectedIcon: Ionicons.settings,
              isSelected: context.isSettingsRoute,
              onPressed: () => context.go(AppRoutes.settings),
            ),
          ],
        ),
      ),
    );
  }
}

class _MainNavBarItem extends StatelessWidget {
  const _MainNavBarItem({
    required this.label,
    required this.icon,
    required this.selectedIcon,
    required this.isSelected,
    required this.onPressed,
  });

  final String label;
  final IconData icon;
  final IconData selectedIcon;
  final bool isSelected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isSelected ? null : onPressed,
      child: IconButton(
        color: AppColors.primary,
        disabledColor: AppColors.primary,
        onPressed: isSelected ? null : onPressed,
        icon: Icon(
          isSelected ? selectedIcon : icon,
          size: !isSelected ? 32 : 28,
        ),
      ),
    );
  }
}
