import 'package:mobx/mobx.dart';
part 'item.g.dart';
class Item = _Item with _$Item;

abstract class _Item with Store {
  String id;
  String produtoId;
  @observable
  int quantidade;

  _Item({this.id, this.produtoId, this.quantidade = 1});

  _Item.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    produtoId = json['produtoId'];
    quantidade = json['quantidade'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['produtoId'] = this.produtoId;
    data['quantidade'] = this.quantidade;
    return data;
  }
}
