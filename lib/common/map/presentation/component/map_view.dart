import 'dart:math';

import 'package:cooki/common/hook/use_on_widget_load.dart';
import 'package:cooki/common/map/presentation/component/interactive_map.dart';
import 'package:cooki/common/map/presentation/view_model/map_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

const pointsOfInterest = [
  Offset(50, 50),
  Offset(150, 100),
  Offset(200, 200),
];
const userPosition = Offset(100, 150);

class MapView extends HookWidget {
  const MapView({
    required this.controller,
    required this.constraints,
    super.key,
  });

  final TransformationController controller;
  final BoxConstraints constraints;

  void _controllerListener(BuildContext context) {
    final scale = controller.value.getMaxScaleOnAxis();

    context.read<MapViewModel>().add(MapScaleUpdated(scale));
  }

  void _onRecenter(BuildContext context) {
    final mapState = context.read<MapViewModel>().state;

    // Get minimum scale to cover the view with the map
    final coverRatio = _minScale(constraints.biggest, mapState.size);
    controller.value = Matrix4.identity()..scale(max(1.2, coverRatio));

    // Get map coordinates visible at the view's center
    final centerScreenOffset = Offset(
      constraints.maxWidth / 2,
      constraints.maxHeight / 2,
    );
    final coordAtScreenCenter = controller.toScene(centerScreenOffset);

    // Get difference between coords of map center and coords at screen
    // center to find offset needed to center the map
    final centerCoords = mapState.centerCoords;
    final offset = coordAtScreenCenter - centerCoords;

    controller.value.translate(offset.dx, offset.dy);
  }

  double _minScale(Size outside, Size inside) {
    if (outside.width / outside.height > inside.width / inside.height) {
      return outside.width / inside.width;
    } else {
      return outside.height / inside.height;
    }
  }

  @override
  Widget build(BuildContext context) {
    useOnWidgetLoad(
      () => controller.addListener(
        () => _controllerListener(context),
      ),
      cleanup: () => controller.removeListener(
        () => _controllerListener(context),
      ),
    );

    return Stack(
      children: [
        InteractiveMap(
          controller: controller,
          onLoad: () => _onRecenter(context),
        ),
        _MapOverlay(
          onRecenter: () => _onRecenter(context),
        )
      ],
    );
  }
}

class _MapOverlay extends StatelessWidget {
  const _MapOverlay({
    required this.onRecenter,
  });

  final VoidCallback onRecenter;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 16,
      right: 16,
      child: IconButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(Colors.white),
        ),
        icon: const Icon(
          Icons.center_focus_strong_rounded,
        ),
        onPressed: onRecenter,
      ),
    );
  }
}
