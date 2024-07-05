part of 'map_view_model.dart';

sealed class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object> get props => [];
}

class MapScaleUpdated extends MapEvent {
  const MapScaleUpdated(this.scale);

  final double scale;

  @override
  List<Object> get props => [scale];
}

class MapUserCoordinatesRequested extends MapEvent {
  const MapUserCoordinatesRequested();
}

class MapRequestCoordsFlagUpdated extends MapEvent {
  const MapRequestCoordsFlagUpdated(this.shouldFetchUserCoords);

  final bool shouldFetchUserCoords;

  @override
  List<Object> get props => [shouldFetchUserCoords];
}
