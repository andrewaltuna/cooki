import 'package:cooki/feature/map/data/model/coordinates.dart';
import 'package:cooki/feature/map/data/model/input/product_directions_input.dart';
import 'package:cooki/feature/map/data/model/map_details.dart';
import 'package:cooki/feature/beacon/data/model/entity/beacon_details.dart';
import 'package:cooki/feature/map/data/model/nearby_sections_details.dart';

abstract interface class MapRepositoryInterface {
  Future<MapDetails> getMapDetails();
  Future<Coordinates> getUserPosition(List<BeaconDetails> input);
  Future<Directions> getProductDirections(ProductDirectionsInput input);
  Future<NearbySectionsDetails> getNearbySections(Coordinates input);
}
