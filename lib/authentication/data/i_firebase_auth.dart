import 'package:firebase_auth/firebase_auth.dart';

abstract class IFirebaseAuth {
  Future<UserCredential> createUserWithEmailAndPassword(String email, String password);
  Future<UserCredential> loginWithEmailAndPassword(String email, String password);
  Future<void> signOut();
}