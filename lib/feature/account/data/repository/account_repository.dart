import 'package:cooki/feature/account/data/model/input/edit_user_profile_input.dart';
import 'package:cooki/feature/account/data/model/output/user_output.dart';
import 'package:cooki/feature/account/data/remote/account_remote_source.dart';
import 'package:cooki/feature/account/data/repository/account_repository_interface.dart';

class AccountRepository implements AccountRepositoryInterface {
  const AccountRepository(this._remoteSource);

  final AccountRemoteSource _remoteSource;

  @override
  Future<UserOutput> createUserProfile(String name) async {
    return await _remoteSource.createUser(name);
  }

  @override
  Future<UserOutput?> getUserProfile() async {
    return await _remoteSource.getUser();
  }

  @override
  Future<UserOutput> editUserProfile(
    EditUserProfileInput input,
  ) async {
    return await _remoteSource.editUserProfile(input);
  }
}
