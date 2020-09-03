import 'package:flutter/material.dart';
import 'package:kommando/authentication/stores/login_store.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final store = Provider.of<LoginStore>(context);

    return Drawer(
      child: Column(
        children: [
          Container(
            color: Theme.of(context).primaryColor,
            height: 200,
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text("sair"),
            onTap: () {
              store.signOut();
            },
          ),
        ],
      ),
    );
  }
}
