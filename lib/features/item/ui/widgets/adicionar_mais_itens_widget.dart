import 'package:flutter/material.dart';

class AdicionarMaisItensWidget extends StatelessWidget {
  const AdicionarMaisItensWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () {
        print("add");
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