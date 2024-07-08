import 'package:cooki/feature/account/data/model/user_output.dart';
import 'package:cooki/feature/preferences/data/model/input/edit_user_profile_input.dart';
import 'package:cooki/feature/preferences/data/remote/preferences_remote_source.dart';
import 'package:cooki/feature/preferences/data/repository/preferences_repository_interface.dart';

class PreferencesRepository implements PreferencesRepositoryInterface {
  const PreferencesRepository(this._remoteSource);

  final PreferencesRemoteSource _remoteSource;

  @override
  Future<UserOutput> updateUserProfile(EditUserProfileInput input) async {
    return await _remoteSource.updateUserProfile(input);
  }
}
