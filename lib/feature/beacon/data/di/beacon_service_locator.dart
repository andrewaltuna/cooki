import 'package:grocery_helper/feature/beacon/data/repository/beacon_repository.dart';
import 'package:grocery_helper/feature/beacon/data/service/beacon_service.dart';

final beaconService = BeaconService();
final beaconRepository = BeaconRepository(beaconService);
