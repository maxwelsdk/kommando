import 'package:flutter/cupertino.dart';
import 'package:kommando/core/item/models/item.dart';

class Pedido {
  String id;
  String lobbyId;
  String consumidorId;
  List<Item> items;

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
      items = new List<Item>();
      json['items'].forEach((v) {
        items.add(new Item.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['lobbyId'] = this.lobbyId;
    data['consumidorId'] = this.consumidorId;
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
