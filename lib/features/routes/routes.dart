import 'package:flutter/material.dart';
import 'package:kommando/features/home/ui/screen/home_screen.dart';
import 'package:kommando/features/lobby/ui/screen/lobby_screen.dart';

class Routes {
  static const home = "/";
  static const lobby = "/lobbies";

  static Route<dynamic> generate(RouteSettings settings) {
    switch (settings.name) {
      case Routes.home:
        return MaterialPageRoute(
          builder: (context) => HomeScreen(),
        );
        break;
      case Routes.lobby:
        return MaterialPageRoute(
          builder: (context) => LobbyScreen(
            lobbyId: settings.arguments,
          ),
        );
        break;
      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(
              title: Text("404"),
            ),
            body: Center(
              child: Text("Página não existe"),
            ),
          ),
        );
        break;
    }
  }
}
