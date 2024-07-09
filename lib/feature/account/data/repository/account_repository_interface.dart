import 'package:cooki/feature/account/data/model/input/edit_user_profile_input.dart';
import 'package:cooki/feature/account/data/model/output/user_output.dart';

abstract interface class AccountRepositoryInterface {
  Future<UserOutput> createUserProfile(
    String displayName,
  );

  Future<UserOutput?> getUserProfile();

  Future<UserOutput> editUserProfile(
    EditUserProfileInput input,
  );
}
