import 'package:kommando/features/authentication/data/models/personal_data.dart';

abstract class IUser {
  Future pushUser({AppUser user});
  Future fetchUsers();
  Future fetchUser({String id});
  Future deleteUserById({String id});
}
