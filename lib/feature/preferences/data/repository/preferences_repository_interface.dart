import 'package:cooki/feature/account/data/model/user_output.dart';
import 'package:cooki/feature/preferences/data/model/input/edit_user_profile_input.dart';

abstract interface class PreferencesRepositoryInterface {
  Future<UserOutput> updateUserProfile(
    EditUserProfileInput input,
  );
}
