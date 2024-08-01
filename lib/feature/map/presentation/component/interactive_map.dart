import 'package:cooki/common/component/app_icons.dart';
import 'package:cooki/common/hook/use_on_widget_load.dart';
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
      boundaryMargin: EdgeInsets.all(mapSize.longestSide / 8),
      child: SizedBox(
        width: mapSize.width,
        height: mapSize.height,
        child: Stack(
          children: [
            AppIcons.map,
            CustomPaint(
              painter: MapPainter(
                directions: state.directions,
              ),
              child: _MapIndicators(
                isUserPositionInitialLoading: state.isUserPositionLoading,
                userOffset: state.userOffsetFromCenter,
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
    required this.isUserPositionInitialLoading,
    required this.userOffset,
    required this.inverseScale,
  });

  static const _fractionalTranslation = Offset(-0.5, -0.5);

  final bool isUserPositionInitialLoading;
  final Offset userOffset;
  final double inverseScale;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // POIs go before the user indicator
        if (!isUserPositionInitialLoading)
          AnimatedPositioned(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            left: userOffset.dx,
            top: userOffset.dy,
            child: FractionalTranslation(
              translation: _fractionalTranslation,
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
