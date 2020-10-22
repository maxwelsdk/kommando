import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kommando/core/produto/models/produto.dart';
import 'package:kommando/features/categoria/ui/states/categoria_states.dart';
import 'package:kommando/features/categoria/ui/stores/categoria_store.dart';
import 'package:kommando/features/lobby/ui/widgets/top_option_categoria_widget.dart';
import 'package:kommando/features/produto/ui/stores/produto_store.dart';
import 'package:kommando/utils/money_utils.dart';
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
    final _produtoStore = Provider.of<ProdutoStore>(context);

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
              if (state is CategoriaLoadingState) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is CategoriaErrorState) {
                return Center(
                  child: Text(state.message),
                );
              }
              if (state is CategoriaDoneState) {
                return Container(
                  height: 30,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.categorias.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(left: 12),
                        child: OptionCategoriaWidget(
                          texto: state.categorias[index].nome,
                        ),
                      );
                    },
                  ),
                );
              }
              return Container();
            },
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Observer(
                builder: (context) {
                  var state = _categoriaStore.state;
                  if (state is CategoriaDoneState) {
                    return FutureBuilder(
                      future: Future.delayed(Duration.zero, () async {
                        final children = List<Widget>();
                        for (var categoria in state.categorias) {
                          children.add(OptionCategoriaWidget(
                            texto: categoria.nome,
                            isSelected: true,
                          ));
                          children.add(Divider(
                            thickness: 1,
                          ));
                          for (var item in categoria.itens) {
                            final produto =
                                await _produtoStore.getProduto(id: item);
                            children.add(ProdutoWidget(
                              produto: produto,
                            ));
                            children.add(Divider());
                          }
                        }
                        return children;
                      }),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) return CircularProgressIndicator();
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: snapshot.data,
                          ),
                        );
                      },
                    );
                  }
                  return Container();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProdutoWidget extends StatelessWidget {
  final Produto produto;

  const ProdutoWidget({
    Key key,
    this.produto,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          OptionCategoriaWidget(
            texto: produto.titulo,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 14.0),
            child: Text(produto.descricao),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "R\$${MoneyUtils.parseDoubleToMoneyText(produto.preco)}",
                style: TextStyle(fontSize: 24),
              )
            ],
          )
        ],
      ),
    );
  }
}
