import 'package:cooki/feature/beacon/data/di/beacon_service_locator.dart';
import 'package:cooki/feature/beacon/presentation/view_model/beacon_view_model.dart';
import 'package:cooki/feature/chat/data/di/chat_service_locator.dart';
import 'package:cooki/feature/chat/presentation/view_model/chat_view_model.dart';
import 'package:cooki/feature/preferences/data/di/preferences_service_locator.dart';
import 'package:cooki/feature/preferences/presentation/view_model/preferences_view_model.dart';
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
        )
      ],
      child: child,
    );
  }
}
