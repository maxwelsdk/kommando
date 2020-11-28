import 'package:flutter/material.dart';
import 'package:kommando/core/pedido/models/pedido.dart';
import 'package:kommando/features/consumidor/ui/states/consumidor_states.dart';
import 'package:kommando/features/consumidor/ui/stores/consumidor_store.dart';
import 'package:kommando/features/item/ui/stores/my_item_store.dart';
import 'package:kommando/features/lobby/ui/stores/lobby_store.dart';
import 'package:kommando/features/lobby/ui/widgets/conectados_horizontal_list_view_widget.dart';
import 'package:kommando/features/lobby/ui/widgets/conectados_vertical_list_view_widget.dart';
import 'package:kommando/features/lobby/ui/widgets/lista_pedidos_desconhecidos.dart';
import 'package:kommando/features/lobby/ui/widgets/titulo_secao_widget.dart';
import 'package:kommando/features/lobby/ui/widgets/total_acumulado_widget.dart';
import 'package:kommando/features/pedido/ui/states/pedido_states.dart';
import 'package:kommando/features/pedido/ui/stores/pedido_store.dart';
import 'package:provider/provider.dart';

class LobbyDetalhesScreen extends StatelessWidget {
  final String lobbyId;

  const LobbyDetalhesScreen({Key key, this.lobbyId}) : super(key: key);

  Future _buildMeuPedidoDialog(BuildContext context) {
    final _pedidoStore = PedidoStore();
    final _myItemStore = Provider.of<MyItemStore>(context, listen: false);
    final _consumidorStore =
        Provider.of<ConsumidorStore>(context, listen: false);

    if (!_myItemStore.checkedPedidos) {
      return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Não vai dar não"),
          content: Text("Ao menos um item deve estar marcado."),
          actions: [
            FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("OK"))
          ],
        ),
      );
    }

    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text("Este pedido é seu?"),
        content: Text(
          "Ajude nos a identificar os pedidos, para não ter surpresas durante o pagamento.",
        ),
        actions: [
          FlatButton(
            onPressed: () {
              Navigator.pop(context, false);
            },
            child: Text("Não, tô de boas."),
          ),
          FlatButton(
            child: Text("Sim, é meu!"),
            onPressed: () {
              Navigator.pop(context, true);
            },
          )
        ],
      ),
    ).then((value) async {
      if (value) {
        var state = _consumidorStore.state;
        if (state is ConsumidorCreatedState) {
          for (var item in _myItemStore.pedidosDesconhecidos) {
            if (item.checked) {
              _pedidoStore.getPedido(id: item.pedidoId).then((response) {
                if (response is PedidoSucessState) {
                  final novoPedido = Pedido(
                    lobbyId: response.pedido.lobbyId,
                    consumidorId: state.consumidor.id,
                    id: response.pedido.id,
                    items: response.pedido.items,
                  );
                  novoPedido.items.add(item.id);
                  _pedidoStore
                      .updatePedido(pedido: novoPedido)
                      .then((value) => print("foi atualizado"));
                }
              });
            }
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final _myItemStore = Provider.of<MyItemStore>(context);
    final _lobbyStore = LobbyStore();
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
            onPressed: () {
              _buildMeuPedidoDialog(context);
            },
          ),
          FloatingActionButton(
            heroTag: Key("main"),
            backgroundColor: Theme.of(context).primaryColor,
            onPressed: () {
              if (!_myItemStore.checkedPedidos) {
                return showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text("Não vai dar não"),
                    content: Text("Ao menos um item deve estar marcado."),
                    actions: [
                      FlatButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("OK"))
                    ],
                  ),
                );
              }
              return showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text("Para quem vai os pedidos selecionados?"),
                  content: Container(
                      height: 150,
                      width: 200,
                      child: ConectadosVerticalListViewWidget()),
                ),
              ).then((value) => Navigator.pop(context));
            },
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
          ConectadosHorizontalListViewWidget(),
          TituloSecaoWidget(
            child: Text("Total acumulado"),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
            child: FutureBuilder(
                future: _lobbyStore.getTotalAcumulado(lobbyId: lobbyId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done)
                    return Container(
                      height: 70,
                      width: double.infinity,
                      color: Theme.of(context).primaryColor,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  return TotalAcumuladoWidget(
                    total: snapshot.data,
                  );
                }),
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
