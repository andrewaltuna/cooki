import 'package:firebase_auth/firebase_auth.dart';

abstract interface class AuthRepositoryInterface {
  bool get isAuthenticated;

  User? get currentUser;

  Stream<User?> get authStateChanges;

  Future<void> reloadUser();

  Future<String?> getTokenId([bool refresh = false]);

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<void> signOut();
}
