import 'package:kommando/features/authentication/data/models/personal_data.dart';
import 'package:kommando/features/authentication/data/services/authentication_services.dart';
import 'package:kommando/features/signup/ui/screen/widgets/personal_data_widget.dart';
import 'package:kommando/features/user/data/services/user_services.dart';
import 'package:kommando/features/signup/ui/states/signup_states.dart';
import 'package:mobx/mobx.dart';

part 'signup_store.g.dart';

class SignupStore = _SignupStore with _$SignupStore;

abstract class _SignupStore with Store {
  final AuthenticationServices _authenticationServices =
      AuthenticationServices();
  final UserServices _firestoreServices = UserServices();

  @observable
  SignupState state = SignupIdleState();

  @action
  SignupState setState(SignupState value) => this.state = value;

  void createUser({String email, String password, PersonalData personalData}) {
    setState(SignupLoadingState());
    _authenticationServices
        .createUserWithEmailAndPassword(email, password)
        .then((value) {
      value.user.updateProfile(
        displayName: personalData.nome,
      );
      _firestoreServices
          .users()
          .add(personalData.toMap())
          .then((value) => print("salvou"))
          .catchError((onError) => print(onError));
      return setState(SignupSuccesState(value));
    }).catchError((onError) => setState(SignupErrorState(onError)));
  }
}
