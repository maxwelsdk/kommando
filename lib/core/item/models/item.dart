import 'package:mobx/mobx.dart';

part 'item.g.dart';

class Item = _Item with _$Item;

abstract class _Item with Store {
  String id;
  String produtoId;
  String pedidoId;
  @observable
  int quantidade;

  _Item({this.id, this.produtoId, this.quantidade = 1, this.pedidoId});

  // ignore: unused_element
  _Item.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    produtoId = json['produtoId'];
    pedidoId = json['pedidoId'];
    quantidade = json['quantidade'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['produtoId'] = this.produtoId;
    data['pedidoId'] = this.pedidoId;
    data['quantidade'] = this.quantidade;
    return data;
  }
}
