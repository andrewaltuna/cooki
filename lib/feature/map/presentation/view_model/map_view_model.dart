import 'dart:async';

import 'package:cooki/common/enum/view_model_status.dart';
import 'package:cooki/feature/map/data/model/coordinates.dart';
import 'package:cooki/feature/map/data/model/input/product_directions_input.dart';
import 'package:cooki/feature/map/data/model/map_details.dart';
import 'package:cooki/feature/map/data/repository/map_repository_interface.dart';
import 'package:cooki/feature/beacon/data/model/entity/beacon_details.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapViewModel extends Bloc<MapEvent, MapState> {
  MapViewModel(this._repository) : super(const MapState()) {
    on<MapInitialized>(_onInitialized);
    on<MapScaleUpdated>(_onScaleUpdated);
    on<MapUserCoordinatesRequested>(_onUserCoordinatesRequested);
    on<MapUserCoordinatesRequestFlagged>(_onUserCoordinatesRequestFlagged);
    on<MapShoppingListSet>(_onShoppingListSet);
    on<MapProductSet>(_onProductSet);
    on<MapProductDirectionsRequested>(_onProductDirectionsRequested);
  }

  final MapRepositoryInterface _repository;
  Timer? _timer;

  Future<void> _onInitialized(
    MapInitialized _,
    Emitter<MapState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          status: ViewModelStatus.loading,
        ),
      );

      final mapDetails = await _repository.getMapDetails();

      emit(
        state.copyWith(
          status: ViewModelStatus.success,
          mapDetails: mapDetails,
        ),
      );

      _timer = Timer.periodic(
        const Duration(seconds: 5),
        (_) => add(const MapUserCoordinatesRequestFlagged()),
      );
    } on Exception catch (_) {
      emit(
        state.copyWith(
          status: ViewModelStatus.error,
        ),
      );
    }
  }

  void _onScaleUpdated(
    MapScaleUpdated event,
    Emitter<MapState> emit,
  ) {
    emit(state.copyWith(currentScale: event.scale));
  }

  Future<void> _onUserCoordinatesRequested(
    MapUserCoordinatesRequested event,
    Emitter<MapState> emit,
  ) async {
    try {
      if (!state.requestUserPosition) return;
      if (state.userPositionStatus.isLoading ||
          state.userPositionStatus.isLoadingMore) return;

      emit(
        state.copyWith(
          userPositionStatus: state.userPositionStatus.isInitial
              ? ViewModelStatus.loading
              : ViewModelStatus.loadingMore,
        ),
      );

      final coordinates = await _repository.getUserPosition(event.beacons);
      final scaledCoordinates = coordinates.scaleTo(
        state.mapDetails.scaledBy,
      );

      final directions = await _fetchProductDirections(
        scaledCoordinates,
      );

      emit(
        state.copyWith(
          userPositionStatus: ViewModelStatus.success,
          userCoordinates: scaledCoordinates,
          requestUserPosition: false,
          directions: directions,
        ),
      );
    } on Exception catch (error) {
      print(error);
      emit(
        state.copyWith(
          userPositionStatus: ViewModelStatus.error,
        ),
      );
    }
  }

  void _onUserCoordinatesRequestFlagged(
    MapUserCoordinatesRequestFlagged _,
    Emitter<MapState> emit,
  ) {
    if (state.status.isLoading) return;

    emit(state.copyWith(requestUserPosition: !state.requestUserPosition));
  }

  void _onShoppingListSet(
    MapShoppingListSet event,
    Emitter<MapState> emit,
  ) {
    emit(
      state.copyWith(
        selectedShoppingListId: event.shoppingListId,
      ),
    );
  }

  void _onProductSet(
    MapProductSet event,
    Emitter<MapState> emit,
  ) {
    final wasProductChanged = state.selectedProductId != event.productId;

    if (!wasProductChanged) return;

    emit(
      state.copyWith(
        selectedProductId: event.productId,
        directions: [],
      ),
    );

    add(const MapProductDirectionsRequested());
  }

  Future<void> _onProductDirectionsRequested(
    MapProductDirectionsRequested _,
    Emitter<MapState> emit,
  ) async {
    final directions = await _fetchProductDirections();

    emit(
      state.copyWith(
        directions: directions,
      ),
    );
  }

  Future<Directions> _fetchProductDirections([
    Coordinates? coordinates,
  ]) async {
    if (state.selectedProductId.isEmpty) return [];

    try {
      final userCoordinates = coordinates ?? state.userCoordinates;

      final directions = await _repository.getProductDirections(
        ProductDirectionsInput(
          productId: state.selectedProductId,
          coordinates: userCoordinates.scaleFrom(
            state.mapDetails.scaledBy,
          ),
        ),
      );

      final scaledDirections = directions
          .map(
            (coordinates) => coordinates.scaleTo(
              state.mapDetails.scaledBy,
            ),
          )
          .toList();

      // Connect start of the path with the user's position
      return [userCoordinates, ...scaledDirections];
    } on Exception catch (_) {
      return state.directions;
    }
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
