import 'package:equatable/equatable.dart';
import 'package:flutter_beacon/flutter_beacon.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cooki/common/enum/view_model_status.dart';
import 'package:cooki/common/helper/permission_helper.dart';
import 'package:cooki/feature/beacon/data/model/entity/beacon_details.dart';
import 'package:cooki/feature/beacon/data/model/entity/kalman_filter.dart';
import 'package:cooki/feature/beacon/data/repository/beacon_repository_interface.dart';

part 'beacon_event.dart';
part 'beacon_state.dart';

/// Number of ticks after which a beacon is considered timed out.
const int _ticksUntilTimeOut = 5;

class BeaconViewModel extends Bloc<BeaconEvent, BeaconState> {
  BeaconViewModel(this._beaconRepository) : super(const BeaconState()) {
    on<BeaconSubscriptionInitialized>(_onSubscriptionInitialized);
    on<BeaconPermissionsValidated>(_onPermissionsValidated);
  }

  final BeaconRepositoryInterface _beaconRepository;

  /// Map of Kalman filters for each beacon.
  final Map<String, KalmanFilter> _beaconFilters = {};

  /// Map that tracks the tick that a beacon was last detected.
  final Map<String, int> _beaconLastDetected = {};

  /// Tracks current number of stream ticks.
  int _currentTick = 0;

  Future<void> _onSubscriptionInitialized(
    BeaconSubscriptionInitialized _,
    Emitter<BeaconState> emit,
  ) async {
    _beaconRepository.initializeRegion();

    await emit.forEach(
      _beaconRepository.rangingStream,
      onData: (rangingResult) {
        _currentTick++;

        // Update beacon details with Kalman filter
        final beacons = _updateBeaconDetails(rangingResult.beacons);

        // Remove filters for beacons no longer detected
        _updateFilters(beacons);

        return state.copyWith(
          beacons: beacons,
        );
      },
    );
  }

  List<BeaconDetails> _updateBeaconDetails(
    List<Beacon> streamBeacons,
  ) {
    final beacons = [...state.beacons];

    for (var beacon in streamBeacons) {
      final beaconDetails = BeaconDetails.fromBeacon(beacon);
      final identifier = beaconDetails.identifier;

      // Update beacon last tick detected
      _beaconLastDetected[identifier] = _currentTick;

      // Create Kalman filter for newly detected beacons
      if (!_beaconFilters.containsKey(beaconDetails.identifier)) {
        _beaconFilters[beaconDetails.identifier] =
            KalmanFilter.fromLastEstimateWithDefaultValues(beacon.rssi);
      }

      // Apply Kalman filter to RSSI values and update beacon details
      final filteredRssi = _beaconFilters[identifier]!.filter(beacon.rssi);
      final updatedBeaconDetails = beaconDetails.copyWith(
        rssi: filteredRssi,
      );

      // Add/replace beacon details in current list
      final index = beacons.indexWhere(
        (details) => details.identifier == updatedBeaconDetails.identifier,
      );

      if (index == -1) {
        beacons.add(updatedBeaconDetails);
      } else {
        beacons[index] = updatedBeaconDetails;
      }
    }

    beacons
      // Remove beacons that have timed out
      ..removeWhere(
        (beacon) {
          final lastSeen = _beaconLastDetected[beacon.identifier]!;

          return _currentTick - lastSeen >= _ticksUntilTimeOut;
        },
      )
      // Sort beacons by RSSI (descending)
      ..sort(
        (a, b) => b.rssi.compareTo(a.rssi),
      );

    return beacons;
  }

  void _updateFilters(List<BeaconDetails> beacons) {
    final idsToRemove = _beaconFilters.keys.map(
      (id) {
        final shouldRemove = !beacons.any(
          (details) => id == details.identifier,
        );

        return shouldRemove ? id : null;
      },
    ).toList();

    idsToRemove.forEach(_beaconFilters.remove);
  }

  Future<void> _onPermissionsValidated(
    BeaconPermissionsValidated event,
    Emitter<BeaconState> emit,
  ) async {
    emit(state.copyWith(permissionStatus: ViewModelStatus.loading));

    final arePermissionsGranted =
        await PermissionHelper.validateBeaconPermissions();

    emit(
      state.copyWith(
        permissionStatus: ViewModelStatus.success,
        arePermissionsGranted: arePermissionsGranted,
      ),
    );
  }
}
