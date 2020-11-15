import 'package:flutter/material.dart';
import 'package:kommando/features/item/data/models/item_dto.dart';
import 'package:kommando/features/item/ui/stores/my_item_store.dart';
import 'package:kommando/features/produto/ui/stores/produto_store.dart';
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
      onPressed: () async {
        final produto = await ProdutoStore().getProduto(id: _myItemStore.item.produtoId);
        _myItemStore.addPedido(
          itemDTO: ItemDTO(
            checked: true,
            preco: produto.preco,
            quantidade: _myItemStore.item.quantidade,
            titulo: produto.titulo,
          )
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
