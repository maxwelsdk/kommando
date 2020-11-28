import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_mobx_helpers/flutter_mobx_helpers.dart';
import 'package:kommando/core/pedido/models/pedido.dart';
import 'package:kommando/features/consumidor/ui/states/consumidor_states.dart';
import 'package:kommando/features/consumidor/ui/stores/consumidor_store.dart';
import 'package:kommando/features/item/ui/stores/my_item_store.dart';
import 'package:kommando/features/lobby/ui/states/lobby_states.dart';
import 'package:kommando/features/lobby/ui/stores/lobby_store.dart';
import 'package:kommando/features/pedido/ui/states/pedido_states.dart';
import 'package:kommando/features/pedido/ui/stores/pedido_store.dart';
import 'package:kommando/features/user/ui/states/user_states.dart';
import 'package:kommando/features/user/ui/stores/user_store.dart';
import 'package:provider/provider.dart';

class ConectadosVerticalListViewWidget extends StatelessWidget {
  const ConectadosVerticalListViewWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lobbyStore = Provider.of<LobbyStore>(context);
    final _myItemStore = Provider.of<MyItemStore>(context);
    final ConsumidorStore _consumidorStore = ConsumidorStore();
    final _pedidoStore = PedidoStore();

    return ObserverListener(
      listener: (_) async {
        var state = _consumidorStore.state;
        if (state is ConsumidorIdleState) {
          var lobbyState = lobbyStore.state;
          if (lobbyState is LobbyConnectedState) {
            await _consumidorStore.getConsumidores(
                lobbyId: lobbyState.lobby.id);
          }
        }
      },
      child: Observer(
        builder: (context) {
          var consumidorState = _consumidorStore.state;
          if (consumidorState is ConsumidorLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (consumidorState is ConsumidorFoundState) {
            final consumidores = consumidorState.consumidores;
            if (consumidores.isEmpty)
              return Text("Não há consumidores conectado.");
            return Container(
              height: 500,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: consumidores.length,
                itemBuilder: (context, index) {
                  final userStore = UserStore();
                  return FutureBuilder(
                      future: userStore.getUser(uid: consumidores[index].uid),
                      builder: (context, snapshot) {
                        var state = userStore.state;
                        if (state is UserLoadingState) {
                          return Center(child: CircularProgressIndicator());
                        }
                        if (state is UserFoundState) {
                          return Card(
                            child: InkWell(
                              onTap: () {
                                for (var item
                                    in _myItemStore.pedidosDesconhecidos) {
                                  if (item.checked) {
                                    _pedidoStore
                                        .getPedido(id: item.pedidoId)
                                        .then((response) {
                                      if (response is PedidoSucessState) {
                                        final novoPedido = Pedido(
                                          lobbyId: response.pedido.lobbyId,
                                          consumidorId: consumidores[index].id,
                                          id: response.pedido.id,
                                          items: response.pedido.items,
                                        );
                                        novoPedido.items.add(item.id);
                                        _pedidoStore
                                            .updatePedido(pedido: novoPedido)
                                            .then((value) =>
                                                print("foi atualizado"));
                                      }
                                    });
                                  }
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(state.user.nome),
                              ),
                            ),
                          );
                        }
                        return Container();
                      });
                },
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
