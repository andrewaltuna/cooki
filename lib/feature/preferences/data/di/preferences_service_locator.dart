import 'package:cooki/common/di/api_service_locator.dart';
import 'package:cooki/feature/preferences/data/remote/preferences_remote_source.dart';
import 'package:cooki/feature/preferences/data/repository/preferences_repository.dart';

final preferencesRemoteSource = PreferencesRemoteSource(graphQlClient);
final preferencesRepository = PreferencesRepository(preferencesRemoteSource);
