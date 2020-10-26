import 'package:flutter/material.dart';

class TotalAcumuladoWidget extends StatelessWidget {
  const TotalAcumuladoWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: double.infinity,
      color: Theme.of(context).primaryColor,
      child: Center(
        child: Text(
          "R\$64,00",
          style: TextStyle(
            color: Colors.white,
            fontSize: 32,
          ),
        ),
      ),
    );
  }
}