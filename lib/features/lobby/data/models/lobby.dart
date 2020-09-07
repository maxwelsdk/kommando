import 'package:kommando/core/consumidor/data/models/consumidor.dart';
import 'package:kommando/features/lobby/data/enum_lobby.dart';

class Lobby {
  int id;
  String descricao;
  LobbyStatus status;
  List<Consumidor> consumidores;

  Lobby.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.descricao = map['descricao'];
    this.status = map['status'];
    this.consumidores = map['consumidores'] ?? List<Consumidor>();
  }

  Map<String, dynamic> toMap(){
    final map = Map<String, dynamic>();
    map['id'] = this.id;
    map['descricao'] = this.descricao;
    map['status'] = this.status;
    map['consumidores'] = this.consumidores;
    return map;
  }
}