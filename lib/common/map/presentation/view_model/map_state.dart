part of 'map_view_model.dart';

class MapState extends Equatable {
  const MapState({
    this.scale = 1.0,
    // TODO: change from placeholders
    this.size = const Size(350, 350),
    this.userCoords = const Offset(0, 0),
    this.shouldFetchUserCoords = false,
  });

  final Size size;
  final double scale;
  final Offset userCoords;
  // TODO: add POIs here

  /// Periodically updated to flag the need to fetch user coordinates.
  final bool shouldFetchUserCoords;

  MapState copyWith({
    Size? size,
    double? scale,
    Offset? userCoords,
    bool? shouldFetchUserCoords,
  }) {
    return MapState(
      size: size ?? this.size,
      scale: scale ?? this.scale,
      userCoords: userCoords ?? this.userCoords,
      shouldFetchUserCoords:
          shouldFetchUserCoords ?? this.shouldFetchUserCoords,
    );
  }

  /// Scale to use to negate the zoom scale of the map.
  double get inverseScale => 1 / scale;

  Offset get centerCoords => Offset(size.width / 2, size.height / 2);

  /// User coordinates relative to the center of the map.
  Offset get userCoordsFromCenter => centerCoords + userCoords;

  @override
  List<Object> get props => [
        size,
        scale,
        userCoords,
      ];
}
