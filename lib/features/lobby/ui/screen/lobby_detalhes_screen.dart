import 'package:flutter/material.dart';
import 'package:kommando/features/lobby/ui/stores/lobby_store.dart';
import 'package:kommando/features/lobby/ui/widgets/conectados_list_view_widget.dart';
import 'package:kommando/features/lobby/ui/widgets/lista_pedidos_desconhecidos.dart';
import 'package:kommando/features/lobby/ui/widgets/titulo_secao_widget.dart';
import 'package:kommando/features/lobby/ui/widgets/total_acumulado_widget.dart';

class LobbyDetalhesScreen extends StatelessWidget {
  final String lobbyId;

  const LobbyDetalhesScreen({Key key, this.lobbyId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            backgroundColor: Theme
                .of(context)
                .primaryColor,
            child: Icon(Icons.person),
            onPressed: () {},
          ),
          FloatingActionButton(
            heroTag: Key("main"),
            backgroundColor: Theme
                .of(context)
                .primaryColor,
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
            child: FutureBuilder(
                future: _lobbyStore.getTotalAcumulado(lobbyId: lobbyId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done)
                    return Container(
                      height: 70,
                      width: double.infinity,
                      color: Theme
                          .of(context)
                          .primaryColor,
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
