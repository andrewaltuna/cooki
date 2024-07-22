import 'package:cooki/common/component/authenticated_blocs.dart';
import 'package:cooki/common/map/presentation/screen/map_screen.dart';
import 'package:cooki/feature/account/presentation/screen/complete_registration_screen.dart';
import 'package:cooki/feature/shopping_list/presentations/screen/shopping_list_item_create_screen.dart';
import 'package:cooki/feature/shopping_list/presentations/screen/shopping_list_screen.dart';
import 'package:cooki/feature/shopping_list/presentations/screen/shopping_lists_screen.dart';
import 'package:cooki/feature/preferences/presentation/screen/preferences_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:cooki/common/navigation/app_routes.dart';
import 'package:cooki/feature/account/presentation/view_model/auth_view_model.dart';
import 'package:cooki/feature/account/presentation/screen/login_screen.dart';
import 'package:cooki/feature/account/presentation/screen/registration_screen.dart';
import 'package:cooki/feature/chat/presentation/screen/chat_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _authShellNavigatorKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  routes: [
    // Unauthenticated routes
    _goRoute(
      path: AppRoutes.login,
      child: const LoginScreen(),
    ),
    _goRoute(
      path: AppRoutes.registration,
      child: const RegistrationScreen(),
    ),
    _goRoute(
      path: AppRoutes.completeRegistration,
      child: const CompleteRegistrationScreen(),
    ),

    // Authenticated routes
    ShellRoute(
      navigatorKey: _authShellNavigatorKey,
      builder: (_, __, child) {
        return AuthenticatedBlocs(
          child: child,
        );
      },
      routes: [
        _goRoute(
          path: AppRoutes.home,
          child: const ChatScreen(),
        ),
        _goRoute(
          path: AppRoutes.map,
          child: const MapScreen(),
        ),
        _goRoute(
          path: AppRoutes.settings,
          child: const PreferencesScreen(),
        ),
        _goRoute(
          path: AppRoutes.shoppingLists,
          child: const ShoppingListsScreen(),
        ),
        // TODO: Consolidate w/ _goRoute
        GoRoute(
          path: '${AppRoutes.shoppingLists}/:id',
          pageBuilder: (_, state) {
            final String shoppingListId = state.pathParameters["id"] as String;
            return _pageWithDefaultTransition(
              state,
              child: ShoppingListScreen(
                id: shoppingListId,
              ),
            );
          },
        ),
        GoRoute(
          path: '${AppRoutes.shoppingLists}/:id/create-item',
          pageBuilder: (_, state) {
            final String shoppingListId = state.pathParameters["id"] as String;
            return _pageWithDefaultTransition(
              state,
              child: ShoppingListItemCreateScreen(
                shoppingListId: shoppingListId,
              ),
            );
          },
        ),
      ],
    ),
  ],
  redirect: (context, state) {
    final authState = context.read<AuthViewModel>().state;

    final isAuthenticated = authState.isFireAuth;
    final isRegistered = authState.isRegistered;

    final isAuthScreen = state.fullPath == AppRoutes.login ||
        state.fullPath == AppRoutes.registration ||
        state.fullPath == AppRoutes.completeRegistration;

    if (isAuthenticated) {
      if (!isRegistered) return AppRoutes.completeRegistration;
      if (isAuthScreen) return AppRoutes.home;
    } else {
      if (!isAuthScreen) return AppRoutes.login;
    }

    return null;
  },
);

GoRoute _goRoute({
  required String path,
  required Widget child,
}) {
  return GoRoute(
    path: path,
    pageBuilder: (_, state) => _pageWithDefaultTransition(
      state,
      child: child,
    ),
  );
}

CustomTransitionPage _pageWithDefaultTransition(
  GoRouterState state, {
  required Widget child,
}) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 50),
    transitionsBuilder: (_, animation, __, child) => FadeTransition(
      opacity: animation,
      child: child,
    ),
  );
}
