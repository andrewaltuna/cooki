import 'package:cooki/common/component/indicator/loading_indicator.dart';
import 'package:cooki/feature/account/data/di/account_service_locator.dart';
import 'package:cooki/feature/account/presentation/view_model/account_view_model.dart';
import 'package:cooki/feature/account/presentation/view_model/auth_view_model.dart';
import 'package:cooki/feature/beacon/data/di/beacon_service_locator.dart';
import 'package:cooki/feature/beacon/presentation/view_model/beacon_view_model.dart';
import 'package:cooki/feature/chat/data/di/chat_service_locator.dart';
import 'package:cooki/feature/chat/presentation/view_model/chat_view_model.dart';
import 'package:cooki/feature/preferences/data/di/preferences_service_locator.dart';
import 'package:cooki/feature/preferences/presentation/view_model/preferences_view_model.dart';
import 'package:cooki/feature/shopping_list/data/di/shopping_list_service_locator.dart';
import 'package:cooki/feature/shopping_list/presentations/view_model/shopping_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Semi-global blocs that are only provided once user is authenticated.
class AuthenticatedBlocs extends StatelessWidget {
  const AuthenticatedBlocs({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          lazy: false,
          create: (_) {
            final initialUser = context.read<AuthViewModel>().state.user;

            return AccountViewModel(accountRepository)
              ..add(AccountInitialized(initialUser));
          },
        ),
        BlocProvider(
          create: (_) => BeaconViewModel(beaconRepository)
            ..add(const BeaconSubscriptionInitialized())
            ..add(const BeaconPermissionsValidated()),
        ),
        BlocProvider(
          create: (_) => ChatViewModel(chatRepository),
        ),
        BlocProvider(
          create: (_) => PreferencesViewModel(preferencesRepository)
            ..add(const PreferencesRequested()),
        ),
        BlocProvider(create: (_) => ShoppingListViewModel(shoppingListRepository)
          ..add(const ShoppingListsRequested()))
      ],
      child: BlocBuilder<AccountViewModel, AccountState>(
        buildWhen: (previous, current) =>
            previous.user.isEmpty || current.user.isEmpty,
        builder: (context, state) {
          if (state.user.isEmpty) {
            return const Scaffold(
              body: Center(
                child: LoadingIndicator(),
              ),
            );
          }

          return child;
        },
      ),
    );
  }
}
