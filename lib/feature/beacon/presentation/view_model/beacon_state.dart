part of 'beacon_view_model.dart';

class BeaconState extends Equatable {
  const BeaconState({
    this.beacons = const [],
  });

  final List<Beacon> beacons;

  BeaconState copyWith({
    List<Beacon>? beacons,
  }) {
    return BeaconState(
      beacons: beacons ?? this.beacons,
    );
  }

  @override
  List<Object> get props => [
        beacons,
      ];
}
