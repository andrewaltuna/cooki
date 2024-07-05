import 'package:cooki/common/component/main_scaffold.dart';
import 'package:cooki/common/map/presentation/component/map_view.dart';
import 'package:cooki/common/map/presentation/view_model/map_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class MapScreen extends HookWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mapController = useTransformationController();

    return MainScaffold(
      title: 'Map',
      contentPadding: EdgeInsets.zero,
      body: BlocProvider(
        create: (_) => MapViewModel(),
        child: LayoutBuilder(
          builder: (_, constraints) {
            return MapView(
              controller: mapController,
              constraints: constraints,
            );
          },
        ),
      ),
    );
  }
}
