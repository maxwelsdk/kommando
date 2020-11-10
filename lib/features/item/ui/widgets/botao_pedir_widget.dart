import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kommando/core/pedido/models/pedido.dart';
import 'package:kommando/features/consumidor/ui/states/consumidor_states.dart';
import 'package:kommando/features/consumidor/ui/stores/consumidor_store.dart';
import 'package:kommando/features/item/ui/states/item_states.dart';
import 'package:kommando/features/item/ui/stores/my_item_store.dart';
import 'package:kommando/features/pedido/ui/states/pedido_states.dart';
import 'package:kommando/features/pedido/ui/stores/pedido_store.dart';
import 'package:kommando/utils/money_utils.dart';
import 'package:provider/provider.dart';

class BotaoPedirWidget extends StatelessWidget {
  final PedidoStore _pedidoStore = PedidoStore();
  final double preco;

  BotaoPedirWidget({
    Key key,
    this.preco,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _consumidorStore = Provider.of<ConsumidorStore>(context);
    final MyItemStore _myItemStore = Provider.of<MyItemStore>(context);

    return Observer(
      builder: (context) {
        var consumidorState = _consumidorStore.state;
        var itemState = _myItemStore.state;
        if (itemState is ItemCreatedState) {
          Navigator.of(context).pop();
          return Text("Pedido enviado!");
        }
        if (itemState is ItemPushingState) {
          return CircularProgressIndicator();
        }

        return Container(
          height: MediaQuery.of(context).size.height * 0.15,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(5),
          ),
          child: FlatButton(
            onPressed: () async {
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
                      final pedido = value.pedido;
                      pedido.items.add(_myItemStore.item.id);
                      await _myItemStore.pushItem(
                          pedidoId: value.pedido.id, item: _myItemStore.item);
                    }
                  }
                });
              }
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "pedir",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                    fontSize: 24,
                  ),
                ),
                Observer(
                  builder: (context) {
                    double value = _myItemStore.item.quantidade * preco;
                    return Text(
                      "R\$${MoneyUtils.parseDoubleToMoneyText(value)}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
