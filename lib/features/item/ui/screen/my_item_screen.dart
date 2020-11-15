import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kommando/features/item/ui/stores/my_item_store.dart';
import 'package:kommando/features/lobby/ui/widgets/pedido_desconhecido_widget.dart';
import 'package:kommando/features/lobby/ui/widgets/titulo_secao_widget.dart';
import 'package:kommando/features/lobby/ui/widgets/total_acumulado_widget.dart';
import 'package:provider/provider.dart';

class MyItemScreen extends StatelessWidget {
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
      body: Observer(
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
                      total: _myItemStore.getTotalAcumuladoPedido,
                    );
                  }),
                ),
                TituloSecaoWidget(
                  child: Text("Pedidos realizados"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
