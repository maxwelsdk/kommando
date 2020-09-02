import 'package:kommando/authentication/data/services/authentication_services.dart';
import 'package:kommando/signup/states/signup_states.dart';
import 'package:mobx/mobx.dart';

part 'signup_store.g.dart';

class SignupStore = _SignupStore with _$SignupStore;

abstract class _SignupStore with Store {
  final _service = AuthenticationServices();

  @observable
  SignupState state = SignupIdleState();

  @action
  SignupState setState(SignupState value) => this.state = value;

  void createUser({String email, String password}) {
    setState(SignupLoadingState());
    _service
        .createUserWithEmailAndPassword(email, password)
        .then((value) => setState(SignupSuccesState(value)))
        .catchError((onError) => setState(SignupErrorState(onError)));
  }
}
