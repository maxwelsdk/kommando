import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kommando/authentication/screen/login_screen.dart';
import 'package:kommando/authentication/stores/login_store.dart';
import 'package:kommando/home/screen/home_screen.dart';
import 'package:kommando/signup/stores/signup_store.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        Provider(
          create: (context) => LoginStore(),
        ),
        Provider(
          create: (context) => SignupStore(),
        )
      ],
      child: MyApp(),
    ),
  );
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
        inputDecorationTheme: buildInputDecorationTheme(context),
        appBarTheme: buildAppBarTheme(context),
      ),
      home: FutureBuilder(
          future: _initialization,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Container(
                color: Colors.red,
                child: Center(
                  child: Text("Falha ao conectar no FirebaseApp"),
                ),
              );
            }
            if (snapshot.connectionState == ConnectionState.done) {
              return StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return LoginScreen();
                  } else {
                    return HomeScreen();
                  }
                },
              );
            }
            return Container(
              color: Theme.of(context).primaryColor,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }),
    );
  }

  AppBarTheme buildAppBarTheme(BuildContext context) {
    return AppBarTheme(
      elevation: 0,
      color: Colors.transparent,
      iconTheme: IconThemeData(
        color: Theme.of(context).primaryColor,
      ),
      textTheme: Typography.blackHelsinki,
      centerTitle: true,
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
