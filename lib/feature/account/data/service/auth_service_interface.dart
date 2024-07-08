import 'package:firebase_auth/firebase_auth.dart';

abstract interface class AuthServiceInterface {
  bool get isAuthenticated;

  Stream<User?> get authStateChanges;

  Future<void> reloadUser();

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
