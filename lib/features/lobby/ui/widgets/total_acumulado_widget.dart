import 'package:flutter/material.dart';
import 'package:kommando/utils/money_utils.dart';

class TotalAcumuladoWidget extends StatelessWidget {
  final double total;
  const TotalAcumuladoWidget({
    Key key, this.total,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 70,
      width: double.infinity,
      color: Theme.of(context).primaryColor,
      child: Center(
        child: Text(
          "R\$${MoneyUtils.parseDoubleToMoneyText(total)}",
          style: TextStyle(
            color: Colors.white,
            fontSize: 32,
          ),
        ),
      ),
    );
  }
}
