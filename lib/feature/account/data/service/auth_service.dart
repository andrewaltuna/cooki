import 'package:firebase_auth/firebase_auth.dart';
import 'package:grocery_helper/feature/account/data/service/auth_service_interface.dart';

class AuthService implements AuthServiceInterface {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  final Stream<User?> authStateChanges =
      FirebaseAuth.instance.authStateChanges();

  @override
  bool get isAuthenticated => _firebaseAuth.currentUser != null;

  @override
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}