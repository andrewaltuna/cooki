part of 'map_view_model.dart';

class MapState extends Equatable {
  const MapState({
    this.status = ViewModelStatus.initial,
    this.userPositionStatus = ViewModelStatus.initial,
    this.currentScale = 1.0,
    this.mapDetails = MapDetails.empty,
    this.userCoordinates = const Coordinates(0, 0),
    this.requestUserPosition = false,
    this.directions = const [],
    this.selectedShoppingListId = '',
    this.selectedProductId = '',
    this.showNearbySection = true,
    this.nearbySectionsDetails = NearbySectionsDetails.empty,
  });

  final ViewModelStatus status;
  final ViewModelStatus userPositionStatus;

  final MapDetails mapDetails;
  final double currentScale;
  final Coordinates userCoordinates;

  /// Periodically updated to flag the need to fetch user coordinates.
  final bool requestUserPosition;
  final Directions directions;

  // Map directions
  final String selectedShoppingListId;
  final String selectedProductId;

  // Overlay
  final bool showNearbySection;
  final NearbySectionsDetails nearbySectionsDetails;

  MapState copyWith({
    ViewModelStatus? status,
    ViewModelStatus? userPositionStatus,
    MapDetails? mapDetails,
    double? currentScale,
    Coordinates? userCoordinates,
    bool? requestUserPosition,
    Directions? directions,
    String? selectedShoppingListId,
    String? selectedProductId,
    bool? showNearbySection,
    NearbySectionsDetails? nearbySectionsDetails,
  }) {
    return MapState(
      status: status ?? this.status,
      userPositionStatus: userPositionStatus ?? this.userPositionStatus,
      mapDetails: mapDetails ?? this.mapDetails,
      currentScale: currentScale ?? this.currentScale,
      userCoordinates: userCoordinates ?? this.userCoordinates,
      requestUserPosition: requestUserPosition ?? this.requestUserPosition,
      directions: directions ?? this.directions,
      selectedShoppingListId:
          selectedShoppingListId ?? this.selectedShoppingListId,
      selectedProductId: selectedProductId ?? this.selectedProductId,
      showNearbySection: showNearbySection ?? this.showNearbySection,
      nearbySectionsDetails:
          nearbySectionsDetails ?? this.nearbySectionsDetails,
    );
  }

  bool get isUserPositionLoading =>
      userPositionStatus.isInitial || userPositionStatus.isLoading;

  /// Scale to use to negate the zoom scale of the map.
  double get inverseScale => 1 / currentScale;

  /// Offset signifying the center of the map.
  Coordinates get centerCoordinates => Coordinates(
        mapDetails.size.width / 2,
        mapDetails.size.height / 2,
      );

  /// User coordinates relative to the center of the map.
  Coordinates get userRelativeCoordinates => toRelativeCoordinates(
        userCoordinates,
      );

  Coordinates? get destination {
    final destination = directions.lastOrNull;

    if (destination == null) return null;

    return toRelativeCoordinates(destination);
  }

  /// Obtain offset relative to the center of the map.
  /// Useful for getting coordinates to plot starting from the top-left corner.
  Coordinates toRelativeCoordinates(Coordinates value) {
    final coordinates = Coordinates(
      value.dx,
      -value.dy,
    );

    return (centerCoordinates + coordinates).toCoordinates();
  }

  @override
  List<Object> get props => [
        status,
        userPositionStatus,
        mapDetails,
        currentScale,
        userCoordinates,
        requestUserPosition,
        directions,
        selectedShoppingListId,
        selectedProductId,
        showNearbySection,
        nearbySectionsDetails,
      ];
}
