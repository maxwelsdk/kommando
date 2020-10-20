import 'package:kommando/features/lobby/data/models/lobby.dart';

abstract class HomeState {}
class HomeIdleState implements HomeState {}
class HomeConnectedState implements HomeState {
  final Lobby lobby;

  HomeConnectedState(this.lobby);
}
class HomeNotFoundState implements HomeState {
  final String message;

  HomeNotFoundState(this.message);
}