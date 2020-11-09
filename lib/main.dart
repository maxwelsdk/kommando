import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kommando/features/consumidor/ui/stores/consumidor_store.dart';
import 'package:kommando/features/home/ui/screen/home_screen.dart';
import 'package:kommando/features/login/ui/screen/login_screen.dart';
import 'package:kommando/features/login/ui/stores/login_store.dart';
import 'package:kommando/features/routes/routes.dart';
import 'package:provider/provider.dart';

import 'features/lobby/ui/stores/lobby_store.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        Provider(
          create: (context) => LoginStore(),
        ),
        Provider(
          create: (context) => LobbyStore(),
        ),
        Provider(
          create: (context) => ConsumidorStore(),
        ),
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
      title: 'Kommando Demo',
      theme: buildThemeData(),
      initialRoute: Routes.home,
      onGenerateRoute: Routes.generate,
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

  ThemeData buildThemeData() {
    Color _primaryColor = const Color(0xFF0C3041);
    Color _accentColor = const Color(0xFF2094EF);

    return ThemeData(
      primaryColor: _primaryColor,
      accentColor: _accentColor,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      inputDecorationTheme: InputDecorationTheme(
        labelStyle:
            TextStyle(color: _primaryColor, fontWeight: FontWeight.bold),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: _primaryColor,
          ),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: _primaryColor,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: _primaryColor,
          ),
        ),
      ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        color: Colors.transparent,
        iconTheme: IconThemeData(
          color: _primaryColor,
        ),
        textTheme: Typography.blackMountainView,
        centerTitle: true,
      ),
    );
  }
}
