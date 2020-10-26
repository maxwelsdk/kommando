import 'package:flutter/material.dart';

class ItemScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalhes do item"),
      ),
      body: Center(
        child: Text("Detalhes do item"),
      )
    );
  }
}
