import 'dart:convert';
import 'dart:io';

import 'package:kommando/core/api/api_services.dart';
import 'package:kommando/core/api/message.dart';
import 'package:kommando/features/lobby/data/i_lobby.dart';
import 'package:kommando/features/lobby/data/models/lobby.dart';

class LobbyServices implements ILobby {
  ApiServices _services = ApiServices();

  @override
  Future deleteLobby({String id}) async {
    final _response = await _services.delete(uri: "/lobbies", id: id);
    switch (_response.statusCode) {
      case HttpStatus.ok:
        return Message(jsonDecode(utf8.decode(_response.bodyBytes))["id"]);
        break;
      default:
        return Message(jsonDecode(utf8.decode(_response.bodyBytes))['message']);
        break;
    }
  }

  @override
  Future fetchLobbies() async {
    final _response = await _services.get(uri: "/lobbies");
    switch (_response.statusCode) {
      case HttpStatus.ok:
        final lobbies = jsonDecode(utf8.decode(_response.bodyBytes))["lobbies"];
        final lobbiesList = List<Lobby>();
        for (var lobby in lobbies) {
          lobbiesList.add(Lobby.fromJson(lobby));
        }
        return lobbiesList;
        break;
      default:
        return Message(jsonDecode(utf8.decode(_response.bodyBytes))['message']);
        break;
    }
  }

  @override
  Future fetchLobby({String id}) async {
    final _response = await _services.get(uri: "/lobbies/$id");
    switch (_response.statusCode) {
      case HttpStatus.ok:
        return Lobby.fromJson(
            jsonDecode(utf8.decode(_response.bodyBytes))["lobby"]);
        break;
      default:
        return Message(jsonDecode(utf8.decode(_response.bodyBytes))['message']);
        break;
    }
  }

  @override
  Future updateLobby({Lobby lobby}) async {
    final _response = await _services.post(uri: "/lobbies", body: lobby);
    switch (_response.statusCode) {
      case HttpStatus.ok:
        return Lobby.fromJson(
            jsonDecode(utf8.decode(_response.bodyBytes))['lobby']);
        break;
      default:
        return Message(jsonDecode(utf8.decode(_response.bodyBytes))['message']);
        break;
    }
  }

  @override
  Future pushLobby({Lobby lobby}) async {
    final _response = await _services.post(uri: "/lobbies", body: lobby);
    switch (_response.statusCode) {
      case HttpStatus.created:
        return Lobby.fromJson(
            jsonDecode(utf8.decode(_response.bodyBytes))['lobby']);
        break;
      default:
        return Message(jsonDecode(utf8.decode(_response.bodyBytes))['message']);
        break;
    }
  }
}
