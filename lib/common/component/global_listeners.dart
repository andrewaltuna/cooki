import 'package:cooki/common/navigation/routing_listeners.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:cooki/feature/beacon/presentation/view_model/beacon_view_model.dart';

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
        ...routingListeners,
      ],
      child: child,
    );
  }
}
