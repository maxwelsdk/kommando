import 'package:flutter/material.dart';
import 'package:kommando/core/produto/models/produto.dart';
import 'package:kommando/features/item/ui/stores/my_item_store.dart';
import 'package:kommando/features/item/ui/widgets/adicionar_mais_itens_widget.dart';
import 'package:kommando/features/item/ui/widgets/botao_pedir_widget.dart';
import 'package:kommando/features/item/ui/widgets/controle_quantidade_widget.dart';
import 'package:kommando/features/lobby/ui/widgets/produto_widget.dart';

class ItemDetalhesScreen extends StatefulWidget {
  final Produto produto;

  ItemDetalhesScreen({Key key, this.produto}) : super(key: key);

  @override
  _ItemDetalhesScreenState createState() => _ItemDetalhesScreenState();
}

class _ItemDetalhesScreenState extends State<ItemDetalhesScreen> {
  final MyItemStore _myItemStore = MyItemStore();

  @override
  void initState() {
    _myItemStore.item.produtoId = widget.produto.id;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalhes do item"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                ProdutoWidget(
                  produto: widget.produto,
                ),
                Divider(
                  thickness: 1,
                ),
                ControleQuantidadeWidget(
                  myItemStore: _myItemStore,
                ),
                AdicionarMaisItensWidget(),
                BotaoPedirWidget(
                  myItemStore: _myItemStore,
                  preco: widget.produto.preco,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
