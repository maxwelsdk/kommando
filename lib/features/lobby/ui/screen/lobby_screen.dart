import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kommando/features/categoria/ui/states/categoria_states.dart';
import 'package:kommando/features/categoria/ui/stores/categoria_store.dart';
import 'package:kommando/features/item/ui/screen/item_detalhes_screen.dart';
import 'package:kommando/features/lobby/ui/screen/lobby_detalhes_screen.dart';
import 'package:kommando/features/lobby/ui/widgets/produto_widget.dart';
import 'package:kommando/features/lobby/ui/widgets/resumo_pedido_widget.dart';
import 'package:kommando/features/lobby/ui/widgets/top_option_categoria_widget.dart';
import 'package:kommando/features/produto/ui/stores/produto_store.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class LobbyScreen extends StatefulWidget {
  final String lobbyId;

  const LobbyScreen({Key key, this.lobbyId}) : super(key: key);

  @override
  _LobbyScreenState createState() => _LobbyScreenState();
}

class _LobbyScreenState extends State<LobbyScreen> {
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  int selectedItem = 0;

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
    final Map map = Map<String, int>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${widget.lobbyId ?? ""}",
        ),
        actions: [
          Center(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          LobbyDetalhesScreen(lobbyId: widget.lobbyId),
                    ));
              },
              child: Text(
                "Detalhes",
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
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
                        child: GestureDetector(
                          onTap: () {
                            itemScrollController.scrollTo(
                              index: map[state.categorias[index].id],
                              curve: Curves.ease,
                              duration: Duration(milliseconds: 200),
                            );
                            setState(() {
                              selectedItem = index;
                            });
                          },
                          child: OptionCategoriaWidget(
                            texto: state.categorias[index].nome,
                            isSelected: index == selectedItem,
                          ),
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
            child: Observer(
              builder: (context) {
                var state = _categoriaStore.state;
                if (state is CategoriaDoneState) {
                  return FutureBuilder(
                    future: Future.delayed(Duration.zero, () async {
                      final children = List<Widget>();
                      for (var categoria in state.categorias) {
                        map[categoria.id] = children.length;
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
                          children.add(
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ItemDetalhesScreen(
                                      produto: produto,
                                    ),
                                  ),
                                );
                              },
                              child: ProdutoWidget(
                                produto: produto,
                              ),
                            ),
                          );
                          children.add(Divider());
                        }
                      }
                      return children;
                    }),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ScrollablePositionedList.builder(
                          itemScrollController: itemScrollController,
                          itemPositionsListener: itemPositionsListener,
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return snapshot.data[index];
                          },
                        ),
                      );
                    },
                  );
                }
                return Container();
              },
            ),
          ),
          ResumoPedidoWidget()
        ],
      ),
    );
  }
}
