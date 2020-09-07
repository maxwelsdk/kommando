import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginState {}

class LoginIdleState implements LoginState {}

class LoginLoadingState implements LoginState {}

class LoginErrorState implements LoginState {
  final FirebaseAuthException firebaseAuthException;

  LoginErrorState(this.firebaseAuthException);
}

class LoginDoneState implements LoginState {
  final UserCredential user;

  LoginDoneState(this.user);
}
