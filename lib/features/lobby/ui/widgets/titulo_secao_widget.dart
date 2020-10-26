import 'package:flutter/material.dart';

class TituloSecaoWidget extends StatelessWidget {
  final Widget child;

  const TituloSecaoWidget({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 18.0, top: 8.0),
      child: child,
    );
  }
}