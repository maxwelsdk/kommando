import 'package:kommando/features/user/data/models/app_user.dart';

abstract class UserState {
}

class UserIdleState implements UserState {}
class UserLoadingState implements UserState {}
class UserErrorState implements UserState {
  final String message;

  UserErrorState(this.message);
}
class UserFoundState implements UserState {
  final AppUser user;

  UserFoundState(this.user);
}