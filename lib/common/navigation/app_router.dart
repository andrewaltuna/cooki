import 'package:cooki/common/component/authenticated_blocs.dart';
import 'package:cooki/common/map/presentation/screen/map_screen.dart';
import 'package:cooki/common/screen/loading_screen.dart';
import 'package:cooki/feature/account/presentation/screen/complete_registration_screen.dart';
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
    child: const LoadingScreen(),
  ),

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
