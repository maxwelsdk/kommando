import 'package:kommando/features/user/data/models/app_user.dart';

abstract class IUser {
  Future pushUser({AppUser user});
  Future fetchUsers();
  Future fetchUser({String uid});
  Future deleteUserById({String id});
}
