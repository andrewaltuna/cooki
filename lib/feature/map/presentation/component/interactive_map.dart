import 'package:cooki/common/component/app_icons.dart';
import 'package:cooki/common/hook/use_on_widget_load.dart';
import 'package:cooki/feature/map/data/model/coordinates.dart';
import 'package:cooki/feature/map/presentation/component/map_painter.dart';
import 'package:cooki/feature/map/presentation/component/map_user_indicator.dart';
import 'package:cooki/feature/map/presentation/view_model/map_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class InteractiveMap extends HookWidget {
  const InteractiveMap({
    required this.controller,
    required this.onLoad,
    super.key,
  });

  final TransformationController controller;
  final VoidCallback onLoad;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<MapViewModel>().state;
    final mapSize = state.mapDetails.size;

    useOnWidgetLoad(
      () {
        if (!state.status.isSuccess) return;

        onLoad();
      },
      keys: [mapSize],
    );

    return InteractiveViewer(
      transformationController: controller,
      constrained: false,
      maxScale: 4,
      minScale: 0.1,
      boundaryMargin: EdgeInsets.all(mapSize.longestSide / 3),
      child: SizedBox(
        width: mapSize.width,
        height: mapSize.height,
        child: Stack(
          children: [
            AppIcons.map,
            CustomPaint(
              painter: MapDirectionsPainter(
                directions: state.directions,
              ),
              child: _MapIndicators(
                showUserPosition: !state.isUserPositionLoading,
                userOffset: state.userRelativeCoordinates,
                destination: state.destination,
                inverseScale: state.inverseScale,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MapIndicators extends StatelessWidget {
  const _MapIndicators({
    required this.showUserPosition,
    required this.destination,
    required this.userOffset,
    required this.inverseScale,
  });

  final bool showUserPosition;
  final Coordinates? destination;
  final Offset userOffset;
  final double inverseScale;

  @override
  Widget build(BuildContext context) {
    final destination = this.destination;

    return Stack(
      children: [
        if (destination != null)
          Positioned(
            top: destination.dy,
            left: destination.dx,
            child: FractionalTranslation(
              translation: const Offset(-0.5, -1),
              child: Transform.scale(
                scale: inverseScale,
                child: const Icon(
                  Icons.location_on,
                  size: 40,
                  color: Colors.red,
                ),
              ),
            ),
          ),
        if (showUserPosition)
          AnimatedPositioned(
            top: userOffset.dy,
            left: userOffset.dx,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            child: FractionalTranslation(
              translation: const Offset(-0.5, -0.5),
              child: MapUserIndicator(
                size: 20,
                inverseScale: inverseScale,
              ),
            ),
          ),
      ],
    );
  }
}
