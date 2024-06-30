import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:grocery_helper/common/navigation/app_router.dart';
import 'package:grocery_helper/feature/account/presentation/view_model/auth_view_model.dart';
import 'package:grocery_helper/feature/beacon/presentation/view_model/beacon_view_model.dart';

class GlobalListeners extends HookWidget {
  const GlobalListeners({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    useOnAppLifecycleStateChange((_, current) {
      if (current != AppLifecycleState.resumed) return;

      context.read<BeaconViewModel>().add(const BeaconPermissionsValidated());
    });

    return MultiBlocListener(
      listeners: [
        BlocListener<AuthViewModel, AuthState>(
          listenWhen: (previous, current) =>
              previous.status != current.status ||
              previous.isAuthenticated != current.isAuthenticated,
          listener: (context, state) {
            if (state.status.isInitial) return;

            appRouter.refresh();
          },
        ),
      ],
      child: child,
    );
  }
}
