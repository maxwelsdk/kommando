import 'package:kommando/features/lobby/data/models/lobby.dart';

abstract class LobbyState {}
class LobbyIdleState implements LobbyState {}
class LobbyConnectedState implements LobbyState {
  final Lobby lobby;

  LobbyConnectedState(this.lobby);
}
class LobbyNotFoundState implements LobbyState {
  final String message;

  LobbyNotFoundState(this.message);
}