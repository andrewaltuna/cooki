import 'package:cooki/feature/preferences/data/model/input/update_preferences_input.dart';
import 'package:cooki/feature/preferences/data/model/output/preferences_output.dart';
import 'package:cooki/feature/preferences/data/remote/preferences_remote_source.dart';
import 'package:cooki/feature/preferences/data/repository/preferences_repository_interface.dart';

class PreferencesRepository implements PreferencesRepositoryInterface {
  const PreferencesRepository(this._remoteSource);

  final PreferencesRemoteSource _remoteSource;

  @override
  Future<PreferencesOutput> getPreferences() async {
    return await _remoteSource.getPreferences();
  }

  @override
  Future<PreferencesOutput> updatePreferences(
    UpdatePreferencesInput input,
  ) async {
    return await _remoteSource.updatePreferences(input);
  }
}
