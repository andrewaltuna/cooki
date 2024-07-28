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

  /// Gets [amount] closest beacons if there are at least [amount].
  List<BeaconDetails>? closestBeaconsOrNull(int amount) {
    if (beacons.length < amount) return null;

    return beacons.take(amount).toList();
  }

  @override
  List<Object> get props => [
        beacons,
        permissionStatus,
        arePermissionsGranted,
      ];
}
