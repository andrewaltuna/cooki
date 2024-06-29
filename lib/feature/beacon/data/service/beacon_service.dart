import 'dart:io';

import 'package:flutter_beacon/flutter_beacon.dart';
import 'package:grocery_helper/feature/beacon/data/service/beacon_service_interface.dart';

class BeaconService implements BeaconServiceInterface {
  final List<Region> _regions = [];

  @override
  Stream<RangingResult> get rangingStream => flutterBeacon.ranging(_regions);

  @override
  void initializeRegion() {
    if (Platform.isIOS) {
      // iOS platform, at least set identifier and proximityUUID for region scanning
      _regions.add(Region(
          identifier: 'Apple Airlocate',
          proximityUUID: 'E2C56DB5-DFFB-48D2-B060-D0F5A71096E0'));
    } else {
      // android platform, it can ranging out of beacon that filter all of Proximity UUID
      _regions.add(Region(identifier: 'com.beacon'));
    }
  }
}
