import 'package:flutter_test/flutter_test.dart';
import 'package:kommando/core/api/api.dart';
import 'package:kommando/features/lobby/data/models/lobby.dart';
import 'package:kommando/features/lobby/data/services/lobby_services.dart';

void main() {
  Api.url = "http://localhost:8080";

  LobbyServices services = LobbyServices();

  group("Teste de Lobby", () {
    test("Teste de criação e deleção de lobby", () async {
      Lobby lobbyToDelete =
      await services.pushLobby(lobby: Lobby(descricao: "Lobby para deletar"));
      final response = await services.deleteLobby(id: lobbyToDelete.id);
      expect(response.message, lobbyToDelete.id);
    });

    test("Busca lista de lobbies", () async {
      await services.pushLobby(lobby: Lobby(descricao: "Lobby 1"));
      await services.pushLobby(lobby: Lobby(descricao: "Lobby 2"));
      final response = await services.fetchLobbies();
      if (response is List<Lobby>) {
        expect(response.isNotEmpty, true);
        response.forEach((element) {
          if (element.id != "5f62b57ef8cbe73384c84aa0")
            services.deleteLobby(id: element.id);
        });
      }
    });

    test("Deve buscar lobby de teste", () async {
      await services
          .fetchLobby(id: "5fa8b90130f8b45ab7204381")
          .then((value) {
        print(value.toJson());
        expect(value.id, "5fa8b90130f8b45ab7204381");
      });
    });
  });
}
