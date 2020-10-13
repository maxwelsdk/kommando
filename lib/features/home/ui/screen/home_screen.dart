import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kommando/features/drawer/ui/widgets/drawer_widget.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
      ),
      drawer: MyDrawer(),
      body: Container(
        child: Column(
          children: [
            Text("Build here ${FirebaseAuth.instance.currentUser}"),
          ],
        ),
      ),
    );
  }
}
