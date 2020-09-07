import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kommando/features/lobby/data/models/lobby.dart';

abstract class ILobby {
  Future<DocumentReference> create(Lobby lobby);
  Future<DocumentReference> update(Lobby lobby);
  Future<void> delete(int lobbyId);
}