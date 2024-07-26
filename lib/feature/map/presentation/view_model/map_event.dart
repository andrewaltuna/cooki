part of 'map_view_model.dart';

sealed class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object> get props => [];
}

class MapInitialized extends MapEvent {
  const MapInitialized();
}

class MapScaleUpdated extends MapEvent {
  const MapScaleUpdated(this.scale);

  final double scale;

  @override
  List<Object> get props => [scale];
}

class MapUserCoordinatesRequested extends MapEvent {
  const MapUserCoordinatesRequested(this.beacons);

  final List<BeaconDetails> beacons;

  @override
  List<Object> get props => [beacons];
}

class MapUserCoordinatesRequestFlagged extends MapEvent {
  const MapUserCoordinatesRequestFlagged();
}

class MapRequestCoordsFlagUpdated extends MapEvent {
  const MapRequestCoordsFlagUpdated(this.shouldFetchUserCoords);

  final bool shouldFetchUserCoords;

  @override
  List<Object> get props => [shouldFetchUserCoords];
}
