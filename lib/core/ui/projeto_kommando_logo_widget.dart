import 'package:flutter/material.dart';

class ProjetoKommandoLogoWidget extends StatelessWidget {
  const ProjetoKommandoLogoWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("projeto"),
        Text(
          "KOMMANDO",
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}