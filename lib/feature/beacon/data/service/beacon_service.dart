import 'package:cooki/constant/beacon_constants.dart';
import 'package:flutter_beacon/flutter_beacon.dart';
import 'package:cooki/feature/beacon/data/service/beacon_service_interface.dart';

class BeaconService implements BeaconServiceInterface {
  final List<Region> _regions = [];

  @override
  Stream<RangingResult> get rangingStream => flutterBeacon.ranging(_regions);

  @override
  void initializeRegion() {
    if (_regions.isNotEmpty) return;

    _regions.add(
      Region(
        identifier: 'Cooki',
        proximityUUID: BeaconConstants.proximityUUID,
      ),
    );
  }
}
