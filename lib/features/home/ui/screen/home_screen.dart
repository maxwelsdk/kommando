import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kommando/core/ui/linear_background_widget.dart';
import 'package:kommando/features/consumidor/ui/states/consumidor_states.dart';
import 'package:kommando/features/consumidor/ui/stores/consumidor_store.dart';
import 'package:kommando/features/drawer/ui/widgets/drawer_widget.dart';
import 'package:kommando/features/home/ui/widgets/qr_code_widget.dart';
import 'package:kommando/features/lobby/ui/states/lobby_states.dart';
import 'package:kommando/features/lobby/ui/stores/lobby_store.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _lobbyStore = Provider.of<LobbyStore>(context);
    final _consumidorStore = Provider.of<ConsumidorStore>(context);
    return Scaffold(
      drawer: MyDrawer(),
      body: Container(
        child: Stack(
          alignment: Alignment.center,
          children: [
            LinearBackgroundWidget(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 24.0),
                      child: Text(
                        "Conectar",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 24.0,
                  ),
                  child: QrCodeWidgetButton(),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.40,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: 8,
                  ),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Recentes"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("PUNCH SMASH BURGER"),
                              Text("R\$ 54,50"),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Observer(
                  builder: (context) {
                    var lobbyState = _lobbyStore.state;
                    var consumidorState = _consumidorStore.state;
                    if (consumidorState is ConsumidorErrorState) {
                      return Text(
                        consumidorState.message,
                        style: TextStyle(color: Colors.white),
                      );
                    }
                    if (lobbyState is LobbyNotFoundState) {
                      return Text(
                        lobbyState.message,
                        style: TextStyle(color: Colors.white),
                      );
                    }
                    return Container();
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
