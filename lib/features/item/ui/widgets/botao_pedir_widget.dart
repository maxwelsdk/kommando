import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kommando/core/pedido/models/pedido.dart';
import 'package:kommando/features/item/ui/stores/my_item_store.dart';
import 'package:kommando/features/lobby/ui/states/lobby_states.dart';
import 'package:kommando/features/lobby/ui/stores/lobby_store.dart';
import 'package:kommando/utils/money_utils.dart';
import 'package:provider/provider.dart';

class BotaoPedirWidget extends StatelessWidget {
  final MyItemStore myItemStore;
  final double preco;

  const BotaoPedirWidget({
    Key key,
    this.myItemStore,
    this.preco,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LobbyStore _lobbyStore = Provider.of<LobbyStore>(context);

    return Container(
      height: MediaQuery.of(context).size.height * 0.15,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: FlatButton(
        onPressed: () {
          var state = _lobbyStore.state as LobbyConnectedState;
          final pedido = Pedido(lobbyId: state.lobby.id, );

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
            Observer(builder: (context) {
              double value = myItemStore.item.quantidade * preco;
              return Text(
                "R\$${MoneyUtils.parseDoubleToMoneyText(value)}",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
