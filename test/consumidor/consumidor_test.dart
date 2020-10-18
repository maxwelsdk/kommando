import 'package:flutter_test/flutter_test.dart';
import 'package:kommando/core/api/api.dart';
import 'package:kommando/core/consumidor/data/models/consumidor.dart';
import 'package:kommando/features/consumidor/data/services/consumidor_services.dart';

void main() {
  Api.url = "http://localhost:8080";

  final ConsumidorServices consumidorServices = ConsumidorServices();

  test("Deve buscar lista de consumidores para a lobby", () async {
    final consumidores = await consumidorServices.fetchConsumidores(
        lobbyId: "5f62b57ef8cbe73384c84aa0");
    if (consumidores is List<Consumidor>) {
      expect(consumidores, isNotEmpty);
    }
  });

  test("Busca lobby inválida de retornar lista vazia", () async {
    final consumidores =
        await consumidorServices.fetchConsumidores(lobbyId: "0123456798");
    if (consumidores is List<Consumidor>) {
      expect(consumidores, isEmpty);
    }
  });

  test("Deve criar um usuário consumidor válido", () async {


  });
}
