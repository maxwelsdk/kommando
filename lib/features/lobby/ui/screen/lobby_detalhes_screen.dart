import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_mobx_helpers/flutter_mobx_helpers.dart';
import 'package:kommando/core/produto/models/produto.dart';
import 'package:kommando/features/item/data/models/item_dto.dart';
import 'package:kommando/features/lobby/ui/states/lobby_states.dart';
import 'package:kommando/features/lobby/ui/stores/lobby_store.dart';
import 'package:kommando/features/lobby/ui/widgets/conectados_list_view_widget.dart';
import 'package:kommando/features/lobby/ui/widgets/pedido_desconhecido_widget.dart';
import 'package:kommando/features/lobby/ui/widgets/titulo_secao_widget.dart';
import 'package:kommando/features/lobby/ui/widgets/total_acumulado_widget.dart';
import 'package:kommando/features/pedido/ui/states/pedido_realizados_state.dart';
import 'package:kommando/features/pedido/ui/states/pedido_states.dart';
import 'package:kommando/features/pedido/ui/stores/pedido_store.dart';
import 'package:kommando/features/produto/ui/stores/produto_store.dart';
import 'package:provider/provider.dart';

class LobbyDetalhesScreen extends StatelessWidget {
  final String lobbyId;

  const LobbyDetalhesScreen({Key key, this.lobbyId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(lobbyId),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: Key("mini"),
            mini: true,
            backgroundColor: Theme.of(context).primaryColor,
            child: Icon(Icons.person),
            onPressed: () {},
          ),
          FloatingActionButton(
            heroTag: Key("main"),
            backgroundColor: Theme.of(context).primaryColor,
            onPressed: () {},
            child: Icon(
              Icons.note_add,
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 18.0,
            ),
            child: Text("Conectados"),
          ),
          ConectadosListViewWidget(),
          TituloSecaoWidget(
            child: Text("Total acumulado"),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
            child: TotalAcumuladoWidget(),
          ),
          TituloSecaoWidget(
            child: Text("Pedidos desconhecidos"),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: ListPedidosDesconhecidosWidget(),
          )
        ],
      ),
    );
  }
}

class ListPedidosDesconhecidosWidget extends StatelessWidget {
  const ListPedidosDesconhecidosWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _providerLobbyStore = Provider.of<LobbyStore>(context);
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
                final List<ItemDTO> itensDTO = List();
                for (var item in state.itens) {
                  await _produtoStore.getProduto(id: item.produtoId).then((value) {
                    if (value is Produto) {
                      itensDTO.add(
                        ItemDTO(
                          produtoId: item.produtoId,
                          titulo: value.titulo,
                          checked: false,
                          quantidade: item.quantidade,
                          preco: value.preco,
                        ),
                      );
                    }
                  });
                }
                itensDTO.forEach((element) {
                  widgets.add(PedidoDesconhecidoWidget(
                    itemDTO: element,
                  ));
                });
                return widgets;
              }),
              builder: (context, snapshot) => snapshot.hasData
                  ? Column(
                      children: snapshot.data,
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
