import 'package:flutter/material.dart';
import 'package:kommando/features/item/data/models/item_dto.dart';
import 'package:kommando/utils/money_utils.dart';

class PedidoDesconhecidoWidget extends StatefulWidget {
  final ItemDTO pedido;

  const PedidoDesconhecidoWidget({
    Key key,
    this.pedido,
  }) : super(key: key);

  @override
  _PedidoDesconhecidoWidgetState createState() =>
      _PedidoDesconhecidoWidgetState();
}

class _PedidoDesconhecidoWidgetState extends State<PedidoDesconhecidoWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: 70,
      ),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
          side: BorderSide(color: Theme.of(context).primaryColor),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Checkbox(
              value: widget.pedido.checked,
              activeColor: Theme.of(context).primaryColor,
              onChanged: (value) {
                setState(() {
                  widget.pedido.checked = value;
                });
              },
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${widget.pedido.quantidade}x ${widget.pedido.titulo}",
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                "R\$${MoneyUtils.parseDoubleToMoneyText(widget.pedido.preco * widget.pedido.quantidade)}",
                style: TextStyle(fontSize: 24),
              ),
            )
          ],
        ),
      ),
    );
  }
}
