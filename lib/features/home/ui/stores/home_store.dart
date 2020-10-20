import 'package:kommando/core/api/message.dart';
import 'package:kommando/features/home/ui/states/home_states.dart';
import 'package:kommando/features/lobby/data/models/lobby.dart';
import 'package:kommando/features/lobby/data/services/lobby_services.dart';
import 'package:mobx/mobx.dart';

part 'home_store.g.dart';

class HomeStore = _HomeStore with _$HomeStore;

abstract class _HomeStore with Store {
  final LobbyServices _lobbyServices = LobbyServices();

  @observable
  HomeState state = HomeIdleState();

  @action
  HomeState setState(HomeState value) => this.state = value;

  Future<void> findLobbyById({String id}) async {
    final foundLobby = await _lobbyServices.fetchLobby(id: id);
    if (foundLobby is Lobby) {
      setState(HomeConnectedState(foundLobby));
    }
    if (foundLobby is Message) {
      setState(HomeNotFoundState(foundLobby.message));
    }
  }
}
