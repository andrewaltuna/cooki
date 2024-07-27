import 'package:cooki/feature/map/data/model/coordinates.dart';
import 'package:cooki/feature/map/data/model/map_details.dart';
import 'package:cooki/feature/beacon/data/model/entity/beacon_details.dart';

abstract interface class MapRepositoryInterface {
  Future<MapDetails> getMapDetails();

  Future<Coordinates> getUserPosition(List<BeaconDetails> input);
}
