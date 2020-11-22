import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_mobx_helpers/flutter_mobx_helpers.dart';
import 'package:kommando/core/produto/models/produto.dart';
import 'package:kommando/features/consumidor/ui/states/consumidor_states.dart';
import 'package:kommando/features/consumidor/ui/stores/consumidor_store.dart';
import 'package:kommando/features/lobby/ui/widgets/produto_widget.dart';
import 'package:kommando/features/pedido/ui/states/pedido_realizados_state.dart';
import 'package:kommando/features/pedido/ui/stores/pedido_store.dart';
import 'package:kommando/features/produto/ui/stores/produto_store.dart';
import 'package:provider/provider.dart';

class PedidosRealizadosWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _pedidoStore = PedidoStore();
    final _produtoStore = ProdutoStore();
    final _consumidorStore = Provider.of<ConsumidorStore>(context);
    return ObserverListener(
      listener: (_) async {
        var consumidorState = _consumidorStore.state;
        if (consumidorState is ConsumidorCreatedState) {
          var consumidor = consumidorState.consumidor;
          await _pedidoStore.getPedidosByLobbyAndConsumidor(
            lobbyId: consumidor.lobbyId,
            consumidorId: consumidor.id,
          );
        }
        return Container();
      },
      child: Observer(
        builder: (context) {
          var state = _pedidoStore.pedidoRealizadoState;
          if (state is ItensPedidosLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ItensPedidosFoundState) {
            return FutureBuilder(
              future: Future.delayed(Duration.zero, () async {
                final List<Produto> produtos = List();
                for (var item in state.itens) {
                  await _produtoStore
                      .getProduto(id: item.produtoId)
                      .then((value) {
                    if (value is Produto) {
                      produtos.add(value);
                    }
                  });
                }
                return Column(
                  children: produtos
                      .map(
                        (e) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ProdutoWidget(
                            produto: e,
                          ),
                        ),
                      )
                      .toList(),
                );
              }),
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done)
                  return CircularProgressIndicator();
                return snapshot.data;
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
