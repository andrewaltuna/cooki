import 'package:cooki/common/component/authenticated_blocs.dart';
import 'package:cooki/common/component/authenticated_listeners.dart';
import 'package:cooki/feature/map/presentation/screen/map_screen.dart';
import 'package:cooki/common/screen/loading_screen.dart';
import 'package:cooki/feature/account/presentation/screen/complete_registration_screen.dart';
import 'package:cooki/feature/shopping_list/presentations/screen/shopping_list_catalog_screen.dart';
import 'package:cooki/feature/shopping_list/presentations/screen/shopping_list_details_screen.dart';
import 'package:cooki/feature/shopping_list/presentations/screen/shopping_list_item_details_screen.dart';
import 'package:cooki/feature/account/presentation/view_model/account_view_model.dart';
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

final _routes = [
  // Default route
  _goRoute(
    path: AppRoutes.loading,
    builder: (_) => const LoadingScreen(),
  ),

  // Unauthenticated routes
  _goRoute(
    path: AppRoutes.login,
    builder: (_) => const LoginScreen(),
  ),
  _goRoute(
    path: AppRoutes.registration,
    builder: (_) => const RegistrationScreen(),
  ),
  _goRoute(
    path: AppRoutes.completeRegistration,
    builder: (_) => const CompleteRegistrationScreen(),
  ),

  // Authenticated routes
  ShellRoute(
    navigatorKey: _authShellNavigatorKey,
    builder: (_, __, child) {
      return AuthenticatedBlocs(
        child: AuthenticatedListeners(
          child: child,
        ),
      );
    },
    routes: [
      _goRoute(
        path: AppRoutes.home,
        builder: (_) => const ChatScreen(),
      ),
      _goRoute(
        path: AppRoutes.map,
        builder: (_) => const MapScreen(),
      ),
      _goRoute(
        path: AppRoutes.settings,
        builder: (_) => const PreferencesScreen(),
      ),
      _goRoute(
        path: AppRoutes.shoppingLists,
        // child: const ShoppingListsScreen(),
        child: const ShoppingListCatalogScreen(),
      ),
      // TODO: Consolidate w/ _goRoute
      GoRoute(
        path: '${AppRoutes.shoppingLists}/:id',
        pageBuilder: (_, state) {
          final String shoppingListId = state.pathParameters["id"] as String;
          return _pageWithDefaultTransition(
            state,
            // child: ShoppingListScreen(
            //   id: shoppingListId,
            // ),
            child: ShoppingListDetailsScreen(
              shoppingListId: shoppingListId,
            ),
          );
        },
      ),
      GoRoute(
        path: '${AppRoutes.shoppingLists}/:id/create-item',
        pageBuilder: (_, state) {
          final String shoppingListId = state.pathParameters["id"] as String;
          return _pageWithDefaultTransition(state,
              // child: ShoppingListItemCreateScreen(
              //   shoppingListId: shoppingListId,
              // ),
              child: ShoppingListItemDetailsScreen(
                shoppingListId: shoppingListId,
              ));
        },
      ),
      GoRoute(
        path: '${AppRoutes.shoppingLists}/:id/edit-item/:itemId',
        pageBuilder: (_, state) {
          final String shoppingListId = state.pathParameters["id"] as String;
          final String shoppingListItemId =
              state.pathParameters["itemId"] as String;
          return _pageWithDefaultTransition(
            state,
            // child: ShoppingListItemUpdateScreen(
            //   shoppingListId: shoppingListId,
            //   shoppingListItemId: shoppingListItemId,
            // ),
            child: ShoppingListItemDetailsScreen(
              shoppingListId: shoppingListId,
              shoppingListItemId: shoppingListItemId,
            ),
          );
        },
      ),
    ],
  ),
];

final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  routes: _routes,
  redirect: (context, state) {
    final authState = context.read<AuthViewModel>().state;
    final accountState = context.read<AccountViewModel>().state;

    final isLoadingScreen = state.fullPath == AppRoutes.loading;
    final isAuthPath = AppRoutes.authPaths.contains(state.fullPath);

    final isAuthLoading = authState.isFetchingAuthStatus ||
        (authState.isAuthorized && accountState.isInitialLoading);

    if (isAuthLoading) return AppRoutes.loading;

    if (authState.isAuthenticated) {
      if (!authState.isRegistered) return AppRoutes.completeRegistration;
      if (accountState.user.isEmpty) return null;
      if (isAuthPath || isLoadingScreen) return AppRoutes.home;
    } else {
      if (!isAuthPath || isLoadingScreen) return AppRoutes.login;
    }

    return null;
  },
);

GoRoute _goRoute({
  required String path,
  required Widget Function(GoRouterState) builder,
  List<RouteBase> routes = const [],
}) {
  return GoRoute(
    path: path,
    routes: routes,
    pageBuilder: (_, state) => _pageWithDefaultTransition(
      state,
      child: builder(state),
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
