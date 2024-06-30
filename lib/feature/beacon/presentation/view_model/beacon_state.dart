part of 'beacon_view_model.dart';

class BeaconState extends Equatable {
  const BeaconState({
    this.beacons = const [],
    this.permissionStatus = ViewModelStatus.initial,
    this.arePermissionsGranted = false,
  });

  final List<Beacon> beacons;

  // Permissions
  final ViewModelStatus permissionStatus;
  final bool arePermissionsGranted;

  BeaconState copyWith({
    List<Beacon>? beacons,
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

  @override
  List<Object> get props => [
        beacons,
        permissionStatus,
        arePermissionsGranted,
      ];
}
