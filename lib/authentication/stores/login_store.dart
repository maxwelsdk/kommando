import 'package:kommando/authentication/data/i_firebase_auth.dart';
import 'package:kommando/authentication/data/services/authentication_services.dart';
import 'package:kommando/authentication/states/login_state.dart';
import 'package:mobx/mobx.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store {
  IFirebaseAuth _service = AuthenticationServices();

  @observable
  LoginState state = LoginIdleState();

  @action
  setState(LoginState value) => this.state = value;

  void createUser({String email, String password}) {
    setState(LoginLoadingState());
    _service
        .createUserWithEmailAndPassword(email, password)
        .then((value) => setState(LoginDoneState(value)))
        .catchError((onError) => setState(LoginErrorState(onError)));
  }

  void loginWithEmailAndPassword({String email, String password}) {
    setState(LoginLoadingState());
    _service
        .loginWithEmailAndPassword(email, password)
        .then((value) => setState(LoginDoneState(value)))
        .catchError((onError) => setState(LoginErrorState(onError)));
  }

  void signOut() {
    _service.signOut();
    setState(LoginIdleState());
  }
}
