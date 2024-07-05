import 'package:cooki/common/hook/use_on_widget_load.dart';
import 'package:cooki/common/map/presentation/component/map_painter.dart';
import 'package:cooki/common/map/presentation/component/map_user_indicator.dart';
import 'package:cooki/common/map/presentation/view_model/map_view_model.dart';
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
    final mapSize = context.select(
      (MapViewModel viewModel) => viewModel.state.size,
    );

    useOnWidgetLoad(
      onLoad,
      keys: [mapSize],
    );

    return InteractiveViewer(
      constrained: false,
      maxScale: 4,
      minScale: 0.2,
      boundaryMargin: EdgeInsets.all(mapSize.longestSide / 10),
      transformationController: controller,
      child: SizedBox(
        width: mapSize.width,
        height: mapSize.height,
        child: const CustomPaint(
          painter: MapPainter(),
          child: _MapIndicators(),
        ),
      ),
    );
  }
}

class _MapIndicators extends StatelessWidget {
  const _MapIndicators();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapViewModel, MapState>(
      builder: (context, state) {
        return Stack(
          children: [
            // POIs go before the user indicator
            AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              left: state.userCoordsFromCenter.dx,
              bottom: state.userCoordsFromCenter.dy,
              child: FractionalTranslation(
                translation: const Offset(-0.5, 0.5),
                child: MapUserIndicator(
                  size: 20,
                  inverseScale: state.inverseScale,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
