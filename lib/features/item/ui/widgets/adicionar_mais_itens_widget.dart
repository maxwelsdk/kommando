import 'package:flutter/material.dart';
import 'package:kommando/core/item/models/item.dart';
import 'package:kommando/features/item/ui/stores/my_item_store.dart';
import 'package:provider/provider.dart';

class AdicionarMaisItensWidget extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  AdicionarMaisItensWidget({
    Key key,
    this.scaffoldKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MyItemStore _myItemStore = Provider.of<MyItemStore>(context);

    return FlatButton(
      onPressed: () {
        _myItemStore.itens.add(
          Item(
            produtoId: _myItemStore.item.produtoId,
            quantidade: _myItemStore.item.quantidade,
          ),
        );
        scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text("Produto adicionado na sacola."),
          ),
        );
      },
      child: Text(
        "adicionar mais itens",
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
