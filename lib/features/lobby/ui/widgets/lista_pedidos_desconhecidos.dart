import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_mobx_helpers/flutter_mobx_helpers.dart';
import 'package:kommando/core/produto/models/produto.dart';
import 'package:kommando/features/item/data/models/item_dto.dart';
import 'package:kommando/features/item/ui/stores/my_item_store.dart';
import 'package:kommando/features/lobby/ui/states/lobby_states.dart';
import 'package:kommando/features/lobby/ui/stores/lobby_store.dart';
import 'package:kommando/features/lobby/ui/widgets/pedido_desconhecido_widget.dart';
import 'package:kommando/features/pedido/ui/states/pedido_realizados_state.dart';
import 'package:kommando/features/pedido/ui/stores/pedido_store.dart';
import 'package:kommando/features/produto/ui/stores/produto_store.dart';
import 'package:provider/provider.dart';

class ListPedidosDesconhecidosWidget extends StatelessWidget {
  const ListPedidosDesconhecidosWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _providerLobbyStore = Provider.of<LobbyStore>(context);
    final _myItemStore = Provider.of<MyItemStore>(context);
    final _pedidoStore = PedidoStore();
    final _produtoStore = ProdutoStore();

    return ObserverListener(
      listener: (_) async {
        var lobbyState = _providerLobbyStore.state;
        if (lobbyState is LobbyConnectedState) {
          await _pedidoStore.getPedidosDesconhecidosByLobby(
              lobbyId: lobbyState.lobby.id);
        }
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
                final List<Widget> widgets = List();
                _myItemStore.pedidosDesconhecidos.clear();
                for (var item in state.itens) {
                  await _produtoStore
                      .getProduto(id: item.produtoId)
                      .then((value) {
                    if (value is Produto) {
                      _myItemStore.pedidosDesconhecidos.add(
                        ItemDTO(
                          id: item.id,
                          produtoId: item.produtoId,
                          pedidoId: item.pedidoId,
                          titulo: value.titulo,
                          checked: false,
                          quantidade: item.quantidade,
                          preco: value.preco,
                        ),
                      );
                    }
                  });
                }
                _myItemStore.pedidosDesconhecidos.forEach((element) {
                  widgets.add(PedidoDesconhecidoWidget(
                    itemDTO: element,
                  ));
                });
                return widgets;
              }),
              builder: (context, snapshot) => snapshot.hasData
                  ? Container(
                      height: 400,
                      child: ListView.builder(
                        itemCount: snapshot.data.length + 1,
                        itemBuilder: (context, index) {
                          if (index == snapshot.data.length)
                            return SizedBox(
                              height: 100,
                            );
                          return snapshot.data[index];
                        },
                      ),
                    )
                  : Container(),
            );
          }
          return Container();
        },
      ),
    );
  }
}
