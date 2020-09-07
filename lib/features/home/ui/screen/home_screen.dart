import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kommando/features/authentication/data/models/personal_data.dart';
import 'package:kommando/features/drawer/ui/widgets/drawer_widget.dart';
import 'package:kommando/features/user/data/services/user_services.dart';
import 'package:kommando/features/login/ui/screen/widgets/custom_button.dart';

class HomeScreen extends StatelessWidget {
  final UserServices _firestoreServices = UserServices();

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
