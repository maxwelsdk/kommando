import 'dart:convert';
import 'dart:io';

import 'package:kommando/core/api/api_services.dart';
import 'package:kommando/features/authentication/data/models/personal_data.dart';
import 'package:kommando/features/user/data/i_user.dart';
import 'package:http/http.dart';

class UserServices implements IUser {
  final ApiServices _services = ApiServices();

  @override
  Future fetchUser({String id}) {
    // TODO: implement fetchUser
    throw UnimplementedError();
  }

  @override
  Future fetchUsers() async {
    final Response _response =
        await _services.get(uri: "/users");
    switch (_response.statusCode) {
      case HttpStatus.ok:
        final usersList = List();
        final json = jsonDecode(utf8.decode(_response.bodyBytes))['users'];
        json.forEach((user) {
          usersList.add(User.fromJson(user));
        });
        return usersList;
      default:
        return null;
    }
  }

  @override
  Future pushUser({User user}) async {
    final Response _response =
        await _services.post(uri: "/users", body: user.toJson());
    print(_response.statusCode);
    print(_response.body);
    switch (_response.statusCode) {
      case HttpStatus.ok:
        return User.fromJson(jsonDecode(utf8.decode(_response.bodyBytes)));
      default:
        return "Falha ao criar usuário";
    }
  }


}
