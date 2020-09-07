import 'package:firebase_auth/firebase_auth.dart';

abstract class SignupState {}

class SignupIdleState implements SignupState {}
class SignupLoadingState implements SignupState {}
class SignupSuccesState implements SignupState {
  final UserCredential userCredential;

  SignupSuccesState(this.userCredential);
}
class SignupErrorState implements SignupState {
  final FirebaseAuthException firebaseAuthException;

  SignupErrorState(this.firebaseAuthException);
}
