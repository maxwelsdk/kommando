import 'package:kommando/core/produto/models/produto.dart';

class Item {
  String id;
  Produto produto;
  int quantidade;

  Item({this.id, this.produto, this.quantidade});

  Item.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    produto =
        json['produto'] != null ? new Produto.fromJson(json['produto']) : null;
    quantidade = json['quantidade'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.produto != null) {
      data['produto'] = this.produto.toJson();
    }
    data['quantidade'] = this.quantidade;
    return data;
  }
}
