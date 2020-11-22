import 'package:flutter_test/flutter_test.dart';
import 'package:kommando/core/api/api.dart';
import 'package:kommando/core/item/models/item.dart';
import 'package:kommando/core/pedido/models/pedido.dart';
import 'package:kommando/features/pedido/data/services/pedido_services.dart';

void main() {
  Api.url = "http://localhost:8080";

  final PedidoServices _pedidoServices = PedidoServices();

  test('Busca pedido por lobby e consumidor', () async {
    await _pedidoServices
        .fetchPedidosByLobbyAndConsumidor(
        lobbyId: "5fa8b90130f8b45ab7204381",
        consumidorId: "5fbab59bb55955068a44001f")
        .then((value) {
      if (value is List<Item>) {
        value.forEach((element) {
          print(element.toJson());
        });
      }
    });
  });

  test("Cria um pedido", () async {
    await _pedidoServices
        .pushPedido(
        pedido: Pedido(
            consumidorId: "5f89f7846062c450e888503c",
            items: [],
            lobbyId: "5f62b57ef8cbe73384c84aa0"))
        .then((value) {
      expect(value.id, isNotEmpty);
      return value;
    }).then((pedidoCriado) async =>
    await _pedidoServices
        .deletePedido(id: pedidoCriado.id)
        .then((value) => expect(value.message, pedidoCriado.id)));
  });

  test("Deve criar um pedido com itens, a deleção não deve ser permitida",
          () async {
        final pedidoCriado = await _pedidoServices
            .pushPedido(
            pedido: Pedido(
                consumidorId: "5f89f7846062c450e888503c",
                items: ["1"],
                lobbyId: "5f62b57ef8cbe73384c84aa0"))
            .then((value) {
          expect(value.id, isNotEmpty);
          return value;
        });

        if (pedidoCriado is Pedido) {
          await _pedidoServices.deletePedido(id: pedidoCriado.id).then((
              value) =>
              expect(
                  value.message, "Pedido possui itens, não pode ser excluído"));

          pedidoCriado.items.clear();

          await _pedidoServices
              .updatePedido(pedido: pedidoCriado)
              .then((value) => expect(value.items, isEmpty));
        }
      });

  test("cria lista de pedidos", () async {
    final listPedidos = List.generate(
        5,
            (index) =>
            Pedido(
                id: "1",
                lobbyId: "5f62b57ef8cbe73384c84aa0",
                items: [],
                consumidorId: "5f89f7846062c450e888503c"));

    for (var pedido in listPedidos) {
      await _pedidoServices
          .pushPedido(pedido: pedido)
          .then((value) => expect(value.id, isNotEmpty));
    }

    final pedidos = await _pedidoServices.fetchPedidos();

    if (pedidos is List<Pedido>) {
      expect(pedidos, isList);
      for (var pedido in pedidos) {
        await _pedidoServices
            .deletePedido(id: pedido.id)
            .then((value) => expect(value.message, pedido.id));
      }
    }
  });

  test("Busca um único pedido", () async {
    final pedido = await _pedidoServices
        .pushPedido(
        pedido: Pedido(
            id: "1",
            lobbyId: "5f62b57ef8cbe73384c84aa0",
            items: [],
            consumidorId: "5f89f7846062c450e888503c"))
        .then((value) {
      expect(value.id, isNotEmpty);
      return value;
    });

    if (pedido is Pedido) {
      await _pedidoServices
          .fetchPedido(id: pedido.id)
          .then((value) => expect(value.id, pedido.id));

      await _pedidoServices
          .deletePedido(id: pedido.id)
          .then((value) => expect(value.message, pedido.id));
    }
  });
}
