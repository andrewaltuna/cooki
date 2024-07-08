import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter_beacon/flutter_beacon.dart';
import 'package:cooki/constant/beacon_constants.dart';

class BeaconDetails extends Equatable {
  const BeaconDetails({
    required this.identifier,
    required this.rssi,
  });

  factory BeaconDetails.fromBeacon(Beacon beacon) {
    return BeaconDetails(
      identifier: '${beacon.major}-${beacon.minor}',
      rssi: beacon.rssi,
    );
  }

  final String identifier;
  final int rssi;

  BeaconDetails copyWith({
    String? identifier,
    int? rssi,
  }) {
    return BeaconDetails(
      identifier: identifier ?? this.identifier,
      rssi: rssi ?? this.rssi,
    );
  }

  double get distanceInMeter {
    final rssiDifference = BeaconConstants.rssiAtOneMeter - rssi;
    const denominator = 10 * BeaconConstants.pathLossExponent;

    return pow(10, rssiDifference / denominator).toDouble();
  }

  @override
  List<Object> get props => [identifier, rssi];
}
