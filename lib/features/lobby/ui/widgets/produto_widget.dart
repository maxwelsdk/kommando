import 'package:flutter/material.dart';
import 'package:kommando/core/produto/models/produto.dart';
import 'package:kommando/features/lobby/ui/widgets/top_option_categoria_widget.dart';
import 'package:kommando/utils/money_utils.dart';

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