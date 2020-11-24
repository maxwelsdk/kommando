import 'package:kommando/core/api/message.dart';
import 'package:kommando/features/lobby/data/models/lobby.dart';
import 'package:kommando/features/lobby/data/services/lobby_services.dart';
import 'package:kommando/features/lobby/ui/states/lobby_states.dart';
import 'package:mobx/mobx.dart';

part 'lobby_store.g.dart';

class LobbyStore = _LobbyStore with _$LobbyStore;

abstract class _LobbyStore with Store {
  final LobbyServices _lobbyServices = LobbyServices();

  @observable
  LobbyState state = LobbyIdleState();

  @action
  LobbyState setState(LobbyState value) => this.state = value;

  Future<void> findLobbyById({String id}) async {
    final foundLobby = await _lobbyServices.fetchLobby(id: id);
    if (foundLobby is Lobby) {
      setState(LobbyConnectedState(foundLobby));
    }
    if (foundLobby is Message) {
      setState(LobbyNotFoundState(foundLobby.message));
    }
  }

}