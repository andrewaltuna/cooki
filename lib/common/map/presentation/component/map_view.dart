import 'package:cooki/common/hook/use_on_widget_load.dart';
import 'package:cooki/common/map/presentation/component/map_painter.dart';
import 'package:cooki/common/map/presentation/component/map_user_indicator.dart';
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
  const MapView({super.key});

  void _controllerListener(
    BuildContext context,
    TransformationController controller,
  ) {
    final scale = controller.value.getMaxScaleOnAxis();

    context.read<MapViewModel>().add(MapScaleUpdated(scale));
  }

  // TODO: Revise/improve
  void _initialMapZoom(
    BuildContext context,
    TransformationController mapController,
    BoxConstraints constraint,
  ) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final renderBox = context.findRenderObject() as RenderBox;
      final childSize = renderBox.size;
      final coverRatio = _coverRatio(constraint.biggest, childSize);

      mapController.value = Matrix4.identity() * coverRatio;
    });
  }

  double _coverRatio(Size outside, Size inside) {
    if (outside.width / outside.height > inside.width / inside.height) {
      return outside.width / inside.width;
    } else {
      return outside.height / inside.height;
    }
  }

  @override
  Widget build(BuildContext context) {
    final mapController = useTransformationController();

    useOnWidgetLoad(
      () {
        mapController.addListener(
          () => _controllerListener(context, mapController),
        );
      },
      cleanup: () => mapController.removeListener(
        () => _controllerListener(context, mapController),
      ),
    );

    return BlocSelector<MapViewModel, MapState, Size>(
      selector: (state) => state.size,
      builder: (_, size) {
        return LayoutBuilder(
          builder: (_, constraints) {
            return InteractiveViewer(
              constrained: false,
              maxScale: 4,
              minScale: 1,
              transformationController: mapController,
              child: SizedBox(
                width: size.width,
                height: size.height,
                child: CustomPaint(
                  painter: const MapPainter(),
                  child: Builder(
                    builder: (context) {
                      _initialMapZoom(context, mapController, constraints);

                      return const _MapIndicators();
                    },
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class _MapIndicators extends HookWidget {
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
