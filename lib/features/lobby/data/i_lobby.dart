import 'package:kommando/features/lobby/data/models/lobby.dart';

abstract class ILobby {
  Future fetchLobby({String id});
  Future fetchLobbies();
  Future deleteLobby({String id});
  Future updateLobby({Lobby lobby});
  Future pushLobby({Lobby lobby});
}