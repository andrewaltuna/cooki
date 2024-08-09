import 'package:cooki/feature/map/data/model/coordinates.dart';
import 'package:cooki/feature/map/data/model/input/product_directions_input.dart';
import 'package:cooki/feature/map/data/model/map_details.dart';
import 'package:cooki/feature/map/data/model/nearby_sections_details.dart';
import 'package:cooki/feature/map/data/remote/map_remote_source.dart';
import 'package:cooki/feature/map/data/repository/map_repository_interface.dart';
import 'package:cooki/feature/beacon/data/model/entity/beacon_details.dart';

class MapRepository implements MapRepositoryInterface {
  const MapRepository(this._remoteSource);

  final MapRemoteSource _remoteSource;

  @override
  Future<MapDetails> getMapDetails() async {
    return _remoteSource.getMapDetails();
  }

  @override
  Future<Coordinates> getUserPosition(List<BeaconDetails> input) async {
    return _remoteSource.getUserPosition(input);
  }

  @override
  Future<Directions> getProductDirections(
    ProductDirectionsInput input,
  ) async {
    return _remoteSource.getProductDirections(input);
  }

  @override
  Future<NearbySectionsDetails> getNearbySections(Coordinates input) {
    return _remoteSource.getNearbySections(input);
  }
}
