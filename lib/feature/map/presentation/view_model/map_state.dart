part of 'map_view_model.dart';

class MapState extends Equatable {
  const MapState({
    this.status = ViewModelStatus.initial,
    this.userPositionStatus = ViewModelStatus.initial,
    this.currentScale = 1.0,
    this.mapDetails = MapDetails.empty,
    this.userOffset = const Offset(0, 0),
    this.requestUserPosition = false,
    this.directions = const [],
  });

  final ViewModelStatus status;
  final ViewModelStatus userPositionStatus;
  final MapDetails mapDetails;
  final double currentScale;
  final Offset userOffset;

  /// Periodically updated to flag the need to fetch user coordinates.
  final bool requestUserPosition;
  final List<Coordinates> directions;

  MapState copyWith({
    ViewModelStatus? status,
    ViewModelStatus? userPositionStatus,
    MapDetails? mapDetails,
    double? currentScale,
    Offset? userOffset,
    bool? requestUserPosition,
    List<Coordinates>? directions,
  }) {
    return MapState(
      status: status ?? this.status,
      userPositionStatus: userPositionStatus ?? this.userPositionStatus,
      mapDetails: mapDetails ?? this.mapDetails,
      currentScale: currentScale ?? this.currentScale,
      userOffset: userOffset ?? this.userOffset,
      requestUserPosition: requestUserPosition ?? this.requestUserPosition,
      directions: directions ?? this.directions,
    );
  }

  bool get isUserPositionLoading =>
      userPositionStatus.isInitial || userPositionStatus.isLoading;

  /// Scale to use to negate the zoom scale of the map.
  double get inverseScale => 1 / currentScale;

  /// Offset signifying the center of the map.
  Offset get centerOffset =>
      Offset(mapDetails.size.width / 2, mapDetails.size.height / 2);

  /// User coordinates relative to the center of the map.
  Offset get userOffsetFromCenter => toRelativeOffset(userOffset);

  /// Obtain offset relative to the center of the map.
  /// Useful for getting coordinates to plot starting from the top-left corner.
  Offset toRelativeOffset(Offset value) {
    final offset = Offset(
      value.dx,
      -value.dy,
    );

    return centerOffset + offset;
  }

  @override
  List<Object> get props => [
        status,
        userPositionStatus,
        mapDetails,
        currentScale,
        userOffset,
        requestUserPosition,
        directions,
      ];
}
