import 'package:flutter/material.dart';

class OptionCategoriaWidget extends StatelessWidget {
  final String texto;
  final bool isSelected;

  const OptionCategoriaWidget({
    Key key,
    @required this.texto,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      texto,
      style: TextStyle(
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        fontSize: 24,
      ),
    );
  }
}