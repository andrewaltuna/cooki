import 'package:cooki/common/di/api_service_locator.dart';
import 'package:cooki/feature/map/data/remote/map_remote_source.dart';
import 'package:cooki/feature/map/data/repository/map_repository.dart';

final mapRemoteSource = MapRemoteSource(graphQlClient);
final mapRepository = MapRepository(mapRemoteSource);
