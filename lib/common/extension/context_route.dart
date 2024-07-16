import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cooki/common/navigation/app_routes.dart';

extension ContextRoute on BuildContext {
  GoRouterState get routerState => GoRouterState.of(this);

  String? get topRoutePath => routerState.topRoute?.path;

  // Route identifiers
  bool get isHomeRoute => topRoutePath == AppRoutes.home;
  bool get isMapRoute => topRoutePath == AppRoutes.map;
  bool get isShoppingListRoute => topRoutePath == AppRoutes.shoppingLists;
  bool get isSettingsRoute => topRoutePath == AppRoutes.settings;
}
