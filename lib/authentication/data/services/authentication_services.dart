import 'package:firebase_auth/firebase_auth.dart';
import 'package:kommando/authentication/data/i_firebase_auth.dart';

class AuthenticationServices implements IFirebaseAuth {
  final firebaseAuth = FirebaseAuth.instance;

  @override
  Future<UserCredential> createUserWithEmailAndPassword(String email, String password) {
    return firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  @override
  Future<UserCredential> loginWithEmailAndPassword(String email, String password) {
    return firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  }

  @override
  Future<UserCredential> signOut() async {
    await firebaseAuth.signOut();
  }
}
