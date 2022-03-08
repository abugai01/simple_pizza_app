//todo: remove unnecessary code

import 'package'
    ':firebase_auth/firebase_auth.dart';
import 'package:simple_pizza_app/models/auth/auth_exception.dart';

abstract class AuthBase {
  User? get currentUser;
  Future<User?> signInWithEmailAndPassword(String email, String password);
  Future<User?> createUserWithEmailAndPassword(String email, String password);
  Future<void> signOut();
}

class Auth implements AuthBase {
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  User? get currentUser => _firebaseAuth.currentUser;

  @override
  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.signInWithCredential(
        EmailAuthProvider.credential(email: email, password: password),
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      throw AuthException.fromCode((e.code));
    }
  }

  @override
  Future<User?> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      throw AuthException.fromCode((e.code));
    }
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
