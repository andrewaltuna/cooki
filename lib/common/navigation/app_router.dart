import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:grocery_helper/common/navigation/app_routes.dart';
import 'package:grocery_helper/feature/account/presentation/view_model/auth_view_model.dart';
import 'package:grocery_helper/feature/account/presentation/screen/login_screen.dart';
import 'package:grocery_helper/feature/account/presentation/screen/registration_screen.dart';
import 'package:grocery_helper/feature/home/presentation/screen/home_screen.dart';

final appRouter = GoRouter(
  initialLocation: AppRoutes.login,
  routes: [
    GoRoute(
      path: AppRoutes.home,
      pageBuilder: (_, state) =>
          _pageWithDefaultTransition(state, child: const HomeScreen()),
    ),
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
  ],
  redirect: (context, state) {
    final isAuthenticated = context.read<AuthViewModel>().state.isAuthenticated;

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