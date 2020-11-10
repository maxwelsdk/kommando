import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kommando/core/produto/models/produto.dart';
import 'package:kommando/features/item/data/models/item_dto.dart';
import 'package:kommando/features/item/ui/stores/my_item_store.dart';
import 'package:kommando/features/lobby/ui/widgets/pedido_desconhecido_widget.dart';
import 'package:kommando/features/lobby/ui/widgets/titulo_secao_widget.dart';
import 'package:kommando/features/lobby/ui/widgets/total_acumulado_widget.dart';
import 'package:kommando/features/produto/data/services/produto_services.dart';
import 'package:provider/provider.dart';

class MyItemScreen extends StatefulWidget {
  @override
  _MyItemScreenState createState() => _MyItemScreenState();
}

class _MyItemScreenState extends State<MyItemScreen> {
  Future _future;

  @override
  void initState() {
    _future = Future.delayed(Duration.zero, () async {
      final MyItemStore _myItemStore =
          Provider.of<MyItemStore>(context, listen: false);
      _myItemStore.pedidos.clear();
      for (var element in _myItemStore.itens) {
        await ProdutoServices()
            .fetchProduto(id: element.produtoId)
            .then((value) {
          if (value is Produto) {
            _myItemStore.pedidos.add(ItemDTO(
              checked: true,
              titulo: value.titulo,
              preco: value.preco,
              quantidade: element.quantidade,
            ));
          }
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final MyItemStore _myItemStore = Provider.of<MyItemStore>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Meus itens"),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          print("enviaaaa");
        },
        child: Icon(Icons.send),
      ),
      body: FutureBuilder(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done)
              return Center(
                child: CircularProgressIndicator(),
              );
            return Column(
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
                              pedido: e,
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
                      total: _myItemStore.getTotalAcumuladoPedido(),
                    );
                  }),
                ),
                TituloSecaoWidget(
                  child: Text("Pedidos realizados"),
                ),
              ],
            );
          }),
    );
  }
}
