import 'package:flutter_test/flutter_test.dart';
import 'package:kommando/core/api/api.dart';
import 'package:kommando/core/consumidor/data/models/consumidor.dart';
import 'package:kommando/features/consumidor/data/services/consumidor_services.dart';
import 'package:kommando/features/lobby/data/models/lobby.dart';
import 'package:kommando/features/lobby/data/services/lobby_services.dart';
import 'package:kommando/features/user/data/models/app_user.dart';
import 'package:kommando/features/user/data/services/user_services.dart';

void main() {
  Api.url = "http://localhost:8080";

  final ConsumidorServices _consumidorServices = ConsumidorServices();

  test("Deve buscar lista de consumidores para a lobby", () async {
    final consumidores = await _consumidorServices.fetchConsumidores(
        lobbyId: "5f62b57ef8cbe73384c84aa0");
    if (consumidores is List<Consumidor>) {
      expect(consumidores, isNotEmpty);
    }
  });

  test("Busca lobby inválida de retornar lista vazia", () async {
    final consumidores =
        await _consumidorServices.fetchConsumidores(lobbyId: "0123456798");
    if (consumidores is List<Consumidor>) {
      expect(consumidores, isEmpty);
    }
  });

  test("Deve criar um usuário consumidor válido", () async {
    final UserServices _userServices = UserServices();
    final LobbyServices _lobbyServices = LobbyServices();
    final AppUser createdUser = await _userServices
        .pushUser(
            user: AppUser(
                uid: "User consumidor Teste",
                cpf: "0123456789",
                displayName: "User Cons T",
                nome: "Belina",
                telefone: "34 3232-9999"))
        .then((value) {
      expect(value.id, isNotNull);
      return value;
    });

    final Lobby createdLobby = await _lobbyServices
        .pushLobby(lobby: Lobby(descricao: "Lobbyzinha safe"))
        .then((value) {
      expect(value.id, isNotNull);
      return value;
    });

    final Consumidor consumidor = await _consumidorServices
        .pushConsumidor(
            consumidor:
                Consumidor(uid: createdUser.uid, lobbyId: createdLobby.id))
        .then((value) {
      expect(value.id, isNotNull);
      return value;
    });

    await _consumidorServices
        .deleteConsumidor(id: consumidor.id)
        .then((value) => expect(value.message, consumidor.id));

    await _lobbyServices
        .deleteLobby(id: createdLobby.id)
        .then((value) => expect(value.message, createdLobby.id));

    await _userServices
        .deleteUserById(id: createdUser.id)
        .then((value) => expect(value.message, createdUser.id));
  });
}
