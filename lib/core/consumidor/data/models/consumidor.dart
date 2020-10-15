import 'package:kommando/core/pedido/models/pedido.dart';

class Consumidor {
  String id;
  String uid;
  String lobbyId;
  List<Pedido> pedidos;

  Consumidor({this.id, this.uid, this.lobbyId, this.pedidos});

  Consumidor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uid = json['uid'];
    lobbyId = json['lobbyId'];
    if (json['pedidos'] != null) {
      pedidos = new List<Pedido>();
      json['pedidos'].forEach((v) {
        pedidos.add(new Pedido.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uid'] = this.uid;
    data['lobbyId'] = this.lobbyId;
    if (this.pedidos != null) {
      data['pedidos'] = this.pedidos.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
