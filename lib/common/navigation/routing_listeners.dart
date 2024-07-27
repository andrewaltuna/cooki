import 'package:cooki/common/navigation/app_router.dart';
import 'package:cooki/feature/account/presentation/view_model/account_view_model.dart';
import 'package:cooki/feature/account/presentation/view_model/auth_view_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void _refreshRouter() => appRouter.refresh();

final routingListeners = [
  BlocListener<AuthViewModel, AuthState>(
    listenWhen: (previous, current) =>
        previous.status != current.status ||
        previous.isAuthenticated != current.isAuthenticated ||
        previous.isRegistered != current.isRegistered,
    listener: (context, state) {
      if (state.isFetchingAuthStatus) return;

      final user = context.read<AccountViewModel>().state.user;

      // User will be populated after finishing final registration form
      if (state.isRegistered && user.isEmpty) {
        context.read<AccountViewModel>().add(const AccountRequested());

        return;
      }

      _refreshRouter();
    },
  ),
  BlocListener<AccountViewModel, AccountState>(
    listenWhen: (previous, current) =>
        previous.user != current.user &&
        previous.user.isEmpty &&
        current.user.isNotEmpty,
    listener: (context, state) {
      if (state.isInitialLoading) return;

      _refreshRouter();
    },
  ),
];
