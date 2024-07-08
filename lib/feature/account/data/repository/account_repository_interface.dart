import 'package:cooki/feature/account/data/model/user_output.dart';

abstract interface class AccountRepositoryInterface {
  Future<UserOutput> createUserProfile(
    String displayName,
  );

  Future<UserOutput?> getUserProfile();
}
