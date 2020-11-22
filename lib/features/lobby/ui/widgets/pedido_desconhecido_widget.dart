import 'package:flutter/material.dart';
import 'package:kommando/features/item/data/models/item_dto.dart';
import 'package:kommando/utils/money_utils.dart';

class PedidoDesconhecidoWidget extends StatefulWidget {
  final ItemDTO itemDTO;

  const PedidoDesconhecidoWidget({
    Key key,
    this.itemDTO,
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
              value: widget.itemDTO.checked,
              activeColor: Theme.of(context).primaryColor,
              onChanged: (value) {
                setState(() {
                  widget.itemDTO.checked = value;
                });
              },
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${widget.itemDTO.quantidade}x ${widget.itemDTO.titulo}",
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                "R\$${MoneyUtils.parseDoubleToMoneyText(widget.itemDTO.preco ?? 0 * widget.itemDTO.quantidade ?? 0)}",
                style: TextStyle(fontSize: 24),
              ),
            )
          ],
        ),
      ),
    );
  }
}
