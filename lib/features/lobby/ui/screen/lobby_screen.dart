import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kommando/features/categoria/ui/states/categoria_states.dart';
import 'package:kommando/features/categoria/ui/stores/categoria_store.dart';
import 'package:provider/provider.dart';

class LobbyScreen extends StatefulWidget {
  final String lobbyId;

  const LobbyScreen({Key key, this.lobbyId}) : super(key: key);

  @override
  _LobbyScreenState createState() => _LobbyScreenState();
}

class _LobbyScreenState extends State<LobbyScreen> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      await Provider.of<CategoriaStore>(context, listen: false).getCategorias();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _categoriaStore = Provider.of<CategoriaStore>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${widget.lobbyId ?? "5f62b57ef8cbe73384c84aa0"}",
        ),
        actions: [
          Center(
            child: Text(
              "Detalhes",
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            width: 12,
          )
        ],
      ),
      body: Column(
        children: [
          Text("PUNCH SMASH BURGER"),
          Observer(
            builder: (context) {
              var state = _categoriaStore.state;
              if (state is CategoriaDoneState) {
                return Container(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.categorias.length,
                    itemBuilder: (context, index) {
                      return index == 0
                          ? Text(
                              "${state.categorias[index].nome}",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          : Text("Categoria $index");
                    },
                  ),
                );
              }
              return Container();
            },
          )
        ],
      ),
    );
  }
}
