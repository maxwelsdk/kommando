import 'package:firebase_auth/firebase_auth.dart';
import 'package:kommando/authentication/data/i_firebase_auth.dart';

class AuthenticationServices implements IFirebaseAuth {
  final firebaseAuth = FirebaseAuth.instance;

  @override
  createUserWithEmailAndPassword(String email, String password) {
    firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  @override
  loginWithEmailAndPassword(String email, String password) {
    firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  }
}
