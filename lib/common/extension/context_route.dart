import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cooki/common/navigation/app_routes.dart';

extension ContextRoute on BuildContext {
  GoRouterState get routerState => GoRouterState.of(this);

  String? get fullPath => routerState.fullPath;

  // Route identifiers
  bool get isHomeRoute => fullPath?.contains(AppRoutes.home) ?? false;
  bool get isMapRoute => fullPath?.contains(AppRoutes.map) ?? false;
  bool get isShoppingListRoute =>
      fullPath?.contains(AppRoutes.shoppingLists) ?? false;
  bool get isSettingsRoute => fullPath?.contains(AppRoutes.settings) ?? false;
}
