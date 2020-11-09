import 'package:flutter/material.dart';

class BotaoPedirWidget extends StatelessWidget {
  const BotaoPedirWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.15,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: FlatButton(
        onPressed: () {},
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "pedir",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.normal,
                fontSize: 24,
              ),
            ),
            Text(
              "R\$ 43,90",
              style: TextStyle(
                color: Colors.white,
                fontSize: 26,
              ),
            )
          ],
        ),
      ),
    );
  }
}