import 'package:cooki/feature/beacon/data/repository/beacon_repository.dart';
import 'package:cooki/feature/beacon/data/service/beacon_service.dart';

final beaconService = BeaconService();
final beaconRepository = BeaconRepository(beaconService);
