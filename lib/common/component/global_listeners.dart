import 'package:cooki/common/navigation/routing_listeners.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GlobalListeners extends StatelessWidget {
  const GlobalListeners({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        ...routingListeners,
      ],
      child: child,
    );
  }
}
