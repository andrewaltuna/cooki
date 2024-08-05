import 'dart:math';

import 'package:cooki/common/component/button/custom_icon_button.dart';
import 'package:cooki/common/component/indicator/error_indicator.dart';
import 'package:cooki/common/component/indicator/loading_indicator.dart';
import 'package:cooki/common/hook/use_on_widget_load.dart';
import 'package:cooki/feature/map/presentation/component/interactive_map.dart';
import 'package:cooki/feature/map/presentation/component/map_directions_selectors.dart';
import 'package:cooki/feature/map/presentation/view_model/map_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

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
    final coverRatio = _minScale(constraints.biggest, mapState.mapDetails.size);
    controller.value = Matrix4.identity()..scale(max(1.2, coverRatio));

    // Get map coordinates visible at the view's center
    final centerScreenOffset = Offset(
      constraints.maxWidth / 2,
      constraints.maxHeight / 2,
    );
    final centerScreenRelativeOffset = controller.toScene(centerScreenOffset);

    // Get difference between user coords and coords at screen
    // center to find offset needed to center the map
    final offset =
        centerScreenRelativeOffset - mapState.userRelativeCoordinates;

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
    final status = context.select(
      (MapViewModel viewModel) => viewModel.state.status,
    );

    if (status.isLoading) {
      return const Center(
        child: LoadingIndicator(),
      );
    }

    if (status.isError) {
      return Center(
        child: ErrorIndicator(
          onRetry: () => context.read<MapViewModel>().add(
                const MapInitialized(),
              ),
        ),
      );
    }

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
        Positioned(
          bottom: 16,
          right: 16,
          child: _RecenterButton(
            onRecenter: () => _onRecenter(context),
          ),
        ),
        const MapDirectionsSelectors(),
      ],
    );
  }
}

class _RecenterButton extends StatelessWidget {
  const _RecenterButton({
    required this.onRecenter,
  });

  final VoidCallback onRecenter;

  @override
  Widget build(BuildContext context) {
    return CustomIconButton(
      icon: Icons.filter_center_focus,
      onPressed: onRecenter,
    );
  }
}
