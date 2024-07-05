import 'dart:async';
import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapViewModel extends Bloc<MapEvent, MapState> {
  MapViewModel() : super(const MapState()) {
    _startTimer();

    on<MapScaleUpdated>(_onScaleUpdated);
    on<MapUserCoordinatesRequested>(_onUserCoordinatesRequested);
  }

  Timer? _timer;

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      add(const MapUserCoordinatesRequested());
    });
  }

  void _onScaleUpdated(
    MapScaleUpdated event,
    Emitter<MapState> emit,
  ) {
    emit(state.copyWith(scale: event.scale));
  }

  void _onUserCoordinatesRequested(
    MapUserCoordinatesRequested event,
    Emitter<MapState> emit,
  ) {
    // TODO: Implement user coordinates fetching
    final coordinates = state.userCoords + _generateUserOffset();

    emit(
      state.copyWith(
        userCoords: coordinates,
        shouldFetchUserCoords: false,
      ),
    );
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}

Offset _generateUserOffset() {
  final xSign = [1, -1]..shuffle();
  final ySign = [1, -1]..shuffle();
  final xValues = List<double>.generate(10, (i) => i + 1)..shuffle();
  final yValues = List<double>.generate(10, (i) => i + 1)..shuffle();

  return Offset(
    xValues.first * xSign.first,
    yValues.first * ySign.first,
  );
}
