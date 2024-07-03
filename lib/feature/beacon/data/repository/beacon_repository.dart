import 'package:flutter_beacon/flutter_beacon.dart';
import 'package:cooki/feature/beacon/data/repository/beacon_repository_interface.dart';
import 'package:cooki/feature/beacon/data/service/beacon_service_interface.dart';

class BeaconRepository implements BeaconRepositoryInterface {
  const BeaconRepository(this._beaconService);

  final BeaconServiceInterface _beaconService;

  @override
  Stream<RangingResult> get rangingStream => _beaconService.rangingStream;

  @override
  void initializeRegion() => _beaconService.initializeRegion();
}
