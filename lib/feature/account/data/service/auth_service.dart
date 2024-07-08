import 'package:firebase_auth/firebase_auth.dart';
import 'package:cooki/feature/account/data/service/auth_service_interface.dart';

class AuthService implements AuthServiceInterface {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  final Stream<User?> authStateChanges =
      FirebaseAuth.instance.authStateChanges();

  @override
  bool get isAuthenticated => _firebaseAuth.currentUser != null;

  @override
  Future<void> reloadUser() async {
    try {
      await _firebaseAuth.currentUser?.reload();
    } catch (error) {
      print(error);
    }
  }

  @override
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (error) {
      print(error);
    }
  }

  @override
  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (error) {
      print(error);
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (error) {
      print(error);
    }
  }
}
