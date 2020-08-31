import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kommando/login/screen/login_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          inputDecorationTheme: buildInputDecorationTheme(context)),
      home: FutureBuilder(
          future: _initialization,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Container(
                color: Colors.red,
                child: Center(
                  child: Text("Falha ao conectar no FirebaseAppko"),
                ),
              );
            }
            if (snapshot.connectionState == ConnectionState.done) {
              return LoginScreen();
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }

  InputDecorationTheme buildInputDecorationTheme(BuildContext context) {
    return InputDecorationTheme(
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Theme.of(context).primaryColor),
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Theme.of(context).primaryColor),
      ),
    );
  }
}
