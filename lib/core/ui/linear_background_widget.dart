import 'package:flutter/material.dart';

class LinearBackgroundWidget extends StatelessWidget {
  const LinearBackgroundWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Theme.of(context).accentColor,
            Theme.of(context).primaryColor,
          ],
          stops: [
            0.1,
            0.7,
          ],
        ),
      ),
    );
  }
}
