import 'dart:math';

import 'package:cooki/common/component/dropdown/custom_dropdown_menu.dart';
import 'package:cooki/common/hook/use_on_widget_load.dart';
import 'package:cooki/feature/map/presentation/component/interactive_map.dart';
import 'package:cooki/feature/map/presentation/view_model/map_view_model.dart';
import 'package:cooki/common/theme/app_colors.dart';
import 'package:cooki/feature/chat/presentation/component/proximity_indicator.dart';
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
    final offset = centerScreenRelativeOffset - mapState.userOffsetFromCenter;

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
        child: CircularProgressIndicator(),
      );
    }

    if (status.isError) {
      return const Center(
        child: Text('Error loading map'),
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
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: CustomDropdownMenu(
            icon: Icon(Icons.shopping_cart),
            hintText: 'Select shopping list',
            fillColor: AppColors.backgroundTextField,
            hasBorder: false,
            entries: [],
          ),
        ),
        const Align(
          alignment: Alignment.bottomCenter,
          child: BeaconProximityIndicator(),
        ),
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
    return IconButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(Colors.white),
      ),
      icon: const Icon(
        Icons.center_focus_strong_rounded,
        size: 30,
      ),
      onPressed: onRecenter,
    );
  }
}
