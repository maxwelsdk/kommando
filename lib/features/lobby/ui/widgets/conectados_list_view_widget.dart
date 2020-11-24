import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_mobx_helpers/flutter_mobx_helpers.dart';
import 'package:kommando/features/consumidor/ui/states/consumidor_states.dart';
import 'package:kommando/features/consumidor/ui/stores/consumidor_store.dart';
import 'package:kommando/features/lobby/ui/states/lobby_states.dart';
import 'package:kommando/features/lobby/ui/stores/lobby_store.dart';
import 'package:kommando/features/user/ui/states/user_states.dart';
import 'package:kommando/features/user/ui/stores/user_store.dart';
import 'package:provider/provider.dart';

class ConectadosListViewWidget extends StatelessWidget {
  const ConectadosListViewWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lobbyStore = Provider.of<LobbyStore>(context);
    final ConsumidorStore _consumidorStore = ConsumidorStore();

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
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
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
                          return Padding(
                            padding:
                                EdgeInsets.only(left: index == 0 ? 18.0 : 4.0),
                            child: CircleAvatar(
                              child: Text(state.user.nome[0].toUpperCase()),
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
