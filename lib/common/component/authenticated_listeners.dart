import 'package:cooki/feature/beacon/presentation/view_model/beacon_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AuthenticatedListeners extends HookWidget {
  const AuthenticatedListeners({
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

    return child;
  }
}
