import 'dart:convert';
import 'dart:io';

import 'package:kommando/core/api/api_services.dart';
import 'package:kommando/core/api/message.dart';
import 'package:kommando/features/user/data/i_user.dart';
import 'package:http/http.dart';
import 'package:kommando/features/user/data/models/app_user.dart';

class UserServices implements IUser {
  final ApiServices _services = ApiServices();

  @override
  Future fetchUser({String id}) async {
    final Response _response = await _services.get(uri: "/users/$id");
    switch (_response.statusCode) {
      case HttpStatus.ok:
        return AppUser.fromJson(
            jsonDecode(utf8.decode(_response.bodyBytes))['user']);
      default:
        return Message(jsonDecode(utf8.decode(_response.bodyBytes))['message']);
    }
  }

  @override
  Future fetchUsers() async {
    final Response _response = await _services.get(uri: "/users");
    switch (_response.statusCode) {
      case HttpStatus.ok:
        final usersList = List();
        final json = jsonDecode(utf8.decode(_response.bodyBytes))['users'];
        json.forEach((user) {
          usersList.add(AppUser.fromJson(user));
        });
        return usersList;
      default:
        return Message(jsonDecode(utf8.decode(_response.bodyBytes))['message']);
    }
  }

  @override
  Future pushUser({AppUser user}) async {
    final Response _response =
        await _services.post(uri: "/users", body: user.toJson());
    switch (_response.statusCode) {
      case HttpStatus.ok:
        return AppUser.fromJson(
            jsonDecode(utf8.decode(_response.bodyBytes))['user']);
      default:
        return Message(jsonDecode(utf8.decode(_response.bodyBytes))['message']);
    }
  }

  @override
  Future deleteUserById({String id}) async {
    final Response _response = await _services.delete(uri: "/users/", id: id);
    switch (_response.statusCode) {
      case HttpStatus.ok:
        return Message(jsonDecode(utf8.decode(_response.bodyBytes))['id']);
      default:
        return Message(jsonDecode(utf8.decode(_response.bodyBytes))['message']);
    }
  }
}
