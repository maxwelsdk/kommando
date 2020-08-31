import 'package:flutter/material.dart';
import 'package:kommando/authentication/stores/login_store.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final store = Provider.of<LoginStore>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
      ),
      drawer: Drawer(
        child: FlatButton(
          child: Text("sair"),
          onPressed: () {
            store.signOut();
          },
        ),
      ),
      body: Container(
        child: Text("Build here"),
      ),
    );
  }
}
