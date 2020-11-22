import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_mobx_helpers/flutter_mobx_helpers.dart';
import 'package:kommando/core/item/models/item.dart';
import 'package:kommando/core/pedido/models/pedido.dart';
import 'package:kommando/features/consumidor/ui/states/consumidor_states.dart';
import 'package:kommando/features/consumidor/ui/stores/consumidor_store.dart';
import 'package:kommando/features/item/ui/states/item_states.dart';
import 'package:kommando/features/item/ui/stores/my_item_store.dart';
import 'package:kommando/features/item/ui/widgets/itens_pedidos_widget.dart';
import 'package:kommando/features/lobby/ui/widgets/pedido_desconhecido_widget.dart';
import 'package:kommando/features/lobby/ui/widgets/titulo_secao_widget.dart';
import 'package:kommando/features/lobby/ui/widgets/total_acumulado_widget.dart';
import 'package:kommando/features/pedido/ui/states/pedido_states.dart';
import 'package:kommando/features/pedido/ui/stores/pedido_store.dart';
import 'package:provider/provider.dart';

class MyItemScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final PedidoStore _pedidoStore = PedidoStore();
    final MyItemStore _myItemStore = Provider.of<MyItemStore>(context);
    final _consumidorStore = Provider.of<ConsumidorStore>(context);

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Meus itens"),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () async {
          var consumidorState = _consumidorStore.state;
          if (consumidorState is ConsumidorCreatedState) {
            await _pedidoStore
                .pushPedido(
              pedido: Pedido(
                consumidorId: consumidorState.consumidor.id,
                lobbyId: consumidorState.consumidor.lobbyId,
              ),
            )
                .then((value) async {
              if (value is PedidoSucessState) {
                if (value.pedido.id != null || value.pedido.id.isNotEmpty) {
                  final List<Item> itens = List();
                  _myItemStore.pedidos.forEach((element) {
                    itens.add(Item(
                      produtoId: element.produtoId,
                      pedidoId: value.pedido.id,
                      quantidade: element.quantidade,
                    ));
                  });
                  await _myItemStore.pushItens(
                    pedidoId: value.pedido.id,
                    itens: itens,
                  );
                }
              }
            });
          }
        },
        child: Icon(Icons.send),
      ),
      body: ObserverListener(
        listener: (_) {
          var state = _myItemStore.state;
          if (state is ItemCreatedState) {
            _scaffoldKey.currentState
                .showSnackBar(SnackBar(content: Text("Pedido enviado!")));
            _myItemStore.setState(ItemIdleState());
          }
        },
        child: Observer(
          builder: (context) {

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TituloSecaoWidget(
                    child: Text("Pedidos pendentes"),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                    child: Column(
                      children: _myItemStore.pedidos
                          .map((e) => PedidoDesconhecidoWidget(
                                itemDTO: e,
                              ))
                          .toList(),
                    ),
                  ),
                  TituloSecaoWidget(
                    child: Text("Total acumulado"),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                    child: Observer(builder: (context) {
                      return TotalAcumuladoWidget(
                        total: _myItemStore.getTotalAcumuladoPedido,
                      );
                    }),
                  ),
                  TituloSecaoWidget(
                    child: Text("Pedidos realizados"),
                  ),
                  PedidosRealizadosWidget(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
