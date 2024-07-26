import 'package:cooki/feature/map/data/model/coordinates.dart';
import 'package:cooki/feature/map/data/model/map_details.dart';
import 'package:cooki/feature/map/data/remote/map_remote_source.dart';
import 'package:cooki/feature/map/data/repository/map_repository_interface.dart';
import 'package:cooki/feature/beacon/data/model/entity/beacon_details.dart';

class MapRepository implements MapRepositoryInterface {
  const MapRepository(this._remoteSource);

  final MapRemoteSource _remoteSource;

  @override
  Future<MapDetails> getMapDetails() async {
    return await _remoteSource.getMapDetails();
  }

  @override
  Future<Coordinates> getUserPosition(List<BeaconDetails> input) async {
    return await _remoteSource.getUserPosition(input);
  }
}
