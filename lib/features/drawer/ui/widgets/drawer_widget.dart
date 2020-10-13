import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kommando/features/login/ui/stores/login_store.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final store = Provider.of<LoginStore>(context);

    return Drawer(
      child: Column(
        children: [
          Text(FirebaseAuth.instance.currentUser.displayName ?? ""),
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
