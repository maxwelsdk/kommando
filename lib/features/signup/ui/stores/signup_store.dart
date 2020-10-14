import 'package:firebase_auth/firebase_auth.dart';
import 'package:kommando/features/authentication/data/models/personal_data.dart';
import 'package:kommando/features/authentication/data/services/authentication_services.dart';
import 'package:kommando/features/signup/ui/states/signup_states.dart';
import 'package:kommando/features/user/data/services/user_services.dart';
import 'package:mobx/mobx.dart';

part 'signup_store.g.dart';

class SignupStore = _SignupStore with _$SignupStore;

abstract class _SignupStore with Store {
  final UserServices _userServices = UserServices();
  final AuthenticationServices _authenticationServices =
      AuthenticationServices();

  @observable
  SignupState state = SignupIdleState();

  @action
  SignupState setState(SignupState value) => this.state = value;

  void createUser({String email, String password, AppUser user}) async {
    setState(SignupLoadingState());
    _authenticationServices
        .createUserWithEmailAndPassword(email, password)
        .then((value) {
          user.uid = value.user.uid;
          value.user.updateProfile(
            displayName: user.nome,
          );
          setState(SignupSuccesState(value));
        })
        .catchError((onError) => setState(SignupErrorState(onError)))
        .whenComplete(() async => await _userServices
            .pushUser(user: user)
            .then((value) => print("user salvo com sucesso!"))
            .catchError((error) {
              if (error is FirebaseAuthException)
              return setState(SignupErrorState(error.message));
            }));
  }
}
