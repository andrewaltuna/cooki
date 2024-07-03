import 'package:flutter_beacon/flutter_beacon.dart';
import 'package:grocery_helper/feature/beacon/data/service/beacon_service_interface.dart';

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
        proximityUUID: '0D89035E-7457-42EB-8250-CE81C78EB402',
      ),
    );
  }
}
