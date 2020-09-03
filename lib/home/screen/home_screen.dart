import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kommando/authentication/data/models/personal_data.dart';
import 'package:kommando/authentication/screen/widgets/custom_button.dart';
import 'package:kommando/authentication/stores/login_store.dart';
import 'package:kommando/firestore/data/services/firestore_services.dart';
import 'package:kommando/home/widgets/drawer_widget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  final FirestoreServices _firestoreServices = FirestoreServices();

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<LoginStore>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
      ),
      drawer: MyDrawer(),
      body: Container(
        child: Column(
          children: [
            Text("Build here ${FirebaseAuth.instance.currentUser}"),
            CustomButton(
              text: "save",
              onPressed: () {
                final personalData = PersonalData(
                    cpf: "000",
                    nome: "Max",
                    telefone: "1231",
                    uid: FirebaseAuth.instance.currentUser.uid);
                _firestoreServices
                    .users()
                    .add(personalData.toMap())
                    .then((value) => print("salvou"))
                    .catchError((onError) => print(onError));
              },
            )
          ],
        ),
      ),
    );
  }
}
