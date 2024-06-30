import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

void useOnWidgetLoad(
  VoidCallback callback, {
  VoidCallback? cleanup,
  List<Object?>? keys,
}) {
  useEffect(
    () {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        callback();
      });

      return () => cleanup?.call();
    },
    keys ?? [],
  );
}
