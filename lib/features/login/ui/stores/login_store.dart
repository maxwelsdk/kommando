import 'package:kommando/features/authentication/data/i_firebase_auth.dart';
import 'package:kommando/features/authentication/data/services/authentication_services.dart';
import 'package:kommando/features/login/ui/states/login_state.dart';
import 'package:mobx/mobx.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store {
  IFirebaseAuth _service = AuthenticationServices();

  @observable
  LoginState state = LoginIdleState();

  @action
  setState(LoginState value) => this.state = value;

  void loginWithEmailAndPassword({String email, String password}) {
    setState(LoginLoadingState());
    _service
        .loginWithEmailAndPassword(email, password)
        .then((value) => setState(LoginDoneState(value)))
        .catchError((onError) => setState(LoginErrorState(onError)))
        .timeout(Duration(seconds: 120), onTimeout: () {
      setState(LoginIdleState());
    });
  }

  void signOut() {
    _service.signOut();
    setState(LoginIdleState());
  }
}
