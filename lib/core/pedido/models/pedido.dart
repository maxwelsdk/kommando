import 'package:flutter/cupertino.dart';

class Pedido {
  String id;
  String lobbyId;
  String consumidorId;
  List<String> items;

  Pedido({
    this.id,
    @required this.lobbyId,
    @required this.consumidorId,
    this.items,
  });

  Pedido.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    lobbyId = json['lobbyId'];
    consumidorId = json['consumidorId'];
    if (json['items'] != null) {
      items = new List<String>();
      json['items'].forEach((v) {
        items.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['lobbyId'] = this.lobbyId;
    data['consumidorId'] = this.consumidorId;
    if (this.items != null) {
      data['items'] = this.items.map((v) => v).toList();
    }
    return data;
  }
}
