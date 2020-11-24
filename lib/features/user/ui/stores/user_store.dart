import 'package:kommando/core/api/message.dart';
import 'package:kommando/features/user/data/models/app_user.dart';
import 'package:kommando/features/user/data/services/user_services.dart';
import 'package:kommando/features/user/ui/states/user_states.dart';
import 'package:mobx/mobx.dart';

part 'user_store.g.dart';

class UserStore = _UserStore with _$UserStore;

abstract class _UserStore with Store {
  final UserServices _userServices = UserServices();

  @observable
  UserState state = UserIdleState();

  @action
  UserState setState(UserState value) => this.state = value;

  Future<void> getUser({String uid}) async {
    setState(UserLoadingState());
    final _response = await _userServices.fetchUser(uid: uid);
    if (_response is Message) {
      setState(UserErrorState(_response.message));
    }
    if (_response is AppUser) {
      setState(UserFoundState(_response));
    }
  }
}