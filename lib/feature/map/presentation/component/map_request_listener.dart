import 'package:cooki/constant/map_constants.dart';
import 'package:cooki/feature/map/presentation/view_model/map_view_model.dart';
import 'package:cooki/feature/beacon/presentation/view_model/beacon_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MapRequestListener extends StatelessWidget {
  const MapRequestListener({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<MapViewModel, MapState>(
      listenWhen: (previous, current) =>
          previous.requestUserPosition != current.requestUserPosition &&
          current.requestUserPosition,
      listener: (context, state) {
        final beacons =
            context.read<BeaconViewModel>().state.closestBeaconsOrNull(3);

        if (beacons == null && !MapConstants.useFixedUserLocation) return;

        context.read<MapViewModel>().add(
              MapUserCoordinatesRequested(beacons ?? []),
            );
      },
      child: child,
    );
  }
}
