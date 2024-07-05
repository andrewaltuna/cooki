import 'package:cooki/feature/chat/data/di/chat_service_locator.dart';
import 'package:cooki/feature/chat/presentation/view_model/chat_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cooki/feature/account/data/di/auth_service_locator.dart';
import 'package:cooki/feature/account/presentation/view_model/auth_view_model.dart';
import 'package:cooki/feature/beacon/data/di/beacon_service_locator.dart';
import 'package:cooki/feature/beacon/presentation/view_model/beacon_view_model.dart';

class GlobalBlocs extends StatelessWidget {
  const GlobalBlocs({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthViewModel(authRepository)
            ..add(
              const AuthStreamInitialized(),
            ),
        ),
        BlocProvider(
          create: (_) => BeaconViewModel(beaconRepository)
            ..add(const BeaconSubscriptionInitialized())
            ..add(const BeaconPermissionsValidated()),
        ),
        BlocProvider(
          create: (_) => ChatViewModel(chatRepository),
        ),
      ],
      child: child,
    );
  }
}
