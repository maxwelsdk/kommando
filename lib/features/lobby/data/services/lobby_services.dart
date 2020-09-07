import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kommando/features/lobby/data/i_lobby.dart';
import 'package:kommando/features/lobby/data/models/lobby.dart';

class LobbyServices implements ILobby {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<DocumentReference> create(Lobby lobby) {
    return _firestore.collection("lobbies").add(lobby.toMap());
  }

  @override
  Future<void> delete(int lobbyId) {
    return _firestore
        .collection("lobbies")
        .where("lobbyId", isEqualTo: lobbyId)
        .get()
        .then((QuerySnapshot value) => value.docs.forEach((doc) {
              doc.reference.delete();
            }));
  }

  @override
  Future<DocumentReference> update(Lobby lobby) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
