import 'dart:async';
import 'dart:ui';

import 'package:cooki/common/enum/view_model_status.dart';
import 'package:cooki/feature/map/data/model/coordinates.dart';
import 'package:cooki/feature/map/data/model/map_details.dart';
import 'package:cooki/feature/map/data/repository/map_repository_interface.dart';
import 'package:cooki/feature/beacon/data/model/entity/beacon_details.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapViewModel extends Bloc<MapEvent, MapState> {
  MapViewModel(this._repository) : super(const MapState()) {
    on<MapInitialized>(_onInitialized);
    on<MapScaleUpdated>(_onScaleUpdated);
    on<MapUserCoordinatesRequested>(_onUserCoordinatesRequested);
    on<MapUserCoordinatesRequestFlagged>(_onUserCoordinatesRequestFlagged);
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

      print('Coordinates: $coordinates');
      final scaledCoordinates = coordinates * state.mapDetails.scaledBy;
      print('Scaled Coordinates: $scaledCoordinates');
      emit(
        state.copyWith(
          userPositionStatus: ViewModelStatus.success,
          userOffset: scaledCoordinates,
          requestUserPosition: false,
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

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
