import 'package:cooki/common/map/presentation/screen/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:cooki/common/navigation/app_routes.dart';
import 'package:cooki/feature/account/presentation/view_model/auth_view_model.dart';
import 'package:cooki/feature/account/presentation/screen/login_screen.dart';
import 'package:cooki/feature/account/presentation/screen/registration_screen.dart';
import 'package:cooki/feature/chat/presentation/screen/chat_screen.dart';
import 'package:cooki/feature/settings/presentation/screen/settings_screen.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: AppRoutes.login,
      pageBuilder: (_, state) =>
          _pageWithDefaultTransition(state, child: const LoginScreen()),
    ),
    GoRoute(
      path: AppRoutes.registration,
      pageBuilder: (_, state) =>
          _pageWithDefaultTransition(state, child: const RegistrationScreen()),
    ),
    GoRoute(
      path: AppRoutes.home,
      pageBuilder: (_, state) =>
          _pageWithDefaultTransition(state, child: const ChatScreen()),
    ),
    GoRoute(
      path: AppRoutes.map,
      pageBuilder: (_, state) =>
          _pageWithDefaultTransition(state, child: const MapScreen()),
    ),
    GoRoute(
      path: AppRoutes.settings,
      pageBuilder: (_, state) =>
          _pageWithDefaultTransition(state, child: const SettingsScreen()),
    ),
  ],
  redirect: (context, state) {
    final authState = context.read<AuthViewModel>().state;

    if (!authState.status.isSuccess) return null;

    final isAuthenticated = authState.isAuthenticated;

    final isAuthScreen = state.fullPath == AppRoutes.login ||
        state.fullPath == AppRoutes.registration;

    if (isAuthenticated && isAuthScreen) return AppRoutes.home;

    if (!isAuthenticated && !isAuthScreen) return AppRoutes.login;

    return null;
  },
);

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
