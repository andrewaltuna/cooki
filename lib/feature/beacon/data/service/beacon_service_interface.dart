import 'package:flutter_beacon/flutter_beacon.dart';

abstract interface class BeaconServiceInterface {
  Stream<RangingResult> get rangingStream;

  void initializeRegion();
}
