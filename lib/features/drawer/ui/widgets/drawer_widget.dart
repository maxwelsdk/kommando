import 'package:cloud_firestore/cloud_firestore.dart';
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
          FutureBuilder<QuerySnapshot>(
              future: store.currentUserPersonalData(uid: FirebaseAuth.instance.currentUser.uid),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text("deu ruim cara"),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  return Container(
                    height: 200,
                    child: Column(
                      children: [
                        Text(snapshot.data.docs[0].get("nome")),
                      ],
                    ),
                  );
                }
                return Container(
                  color: Theme.of(context).primaryColor,
                  height: 200,
                );
              }),
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
