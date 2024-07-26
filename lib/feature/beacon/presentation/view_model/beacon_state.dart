part of 'beacon_view_model.dart';

class BeaconState extends Equatable {
  const BeaconState({
    this.beacons = const [],
    this.permissionStatus = ViewModelStatus.initial,
    this.arePermissionsGranted = false,
  });

  final List<BeaconDetails> beacons;

  // Permissions
  final ViewModelStatus permissionStatus;
  final bool arePermissionsGranted;

  BeaconState copyWith({
    List<BeaconDetails>? beacons,
    bool? arePermissionsGranted,
    ViewModelStatus? permissionStatus,
  }) {
    return BeaconState(
      beacons: beacons ?? this.beacons,
      permissionStatus: permissionStatus ?? this.permissionStatus,
      arePermissionsGranted:
          arePermissionsGranted ?? this.arePermissionsGranted,
    );
  }

  /// Get closest beacons if there are at least [minumum] beacons.
  List<BeaconDetails>? closestBeaconsOrNull(int minumum) {
    if (beacons.length < minumum) return null;

    return beacons;
  }

  @override
  List<Object> get props => [
        beacons,
        permissionStatus,
        arePermissionsGranted,
      ];
}
