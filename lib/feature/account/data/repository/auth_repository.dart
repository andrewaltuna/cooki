import 'package:firebase_auth/firebase_auth.dart';
import 'package:cooki/feature/account/data/repository/auth_repository_interface.dart';
import 'package:cooki/feature/account/data/service/auth_service_interface.dart';

class AuthRepository implements AuthRepositoryInterface {
  AuthRepository(this._authService);

  final AuthServiceInterface _authService;

  @override
  bool get isAuthenticated => _authService.isAuthenticated;

  @override
  Stream<User?> get authStateChanges => _authService.authStateChanges;

  @override
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _authService.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _authService.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> signOut() async {
    await _authService.signOut();
  }
}
