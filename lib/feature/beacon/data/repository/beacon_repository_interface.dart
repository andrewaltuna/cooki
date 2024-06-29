import 'package:flutter_beacon/flutter_beacon.dart';

abstract interface class BeaconRepositoryInterface {
  Stream<RangingResult> get rangingStream;

  void initializeRegion();
}
