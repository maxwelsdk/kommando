import 'package:mobx/mobx.dart';

part 'item_dto.g.dart';

class ItemDTO = _ItemDTO with _$ItemDTO;

abstract class _ItemDTO with Store {
  String id;
  @observable
  bool checked;
  String produtoId;
  String pedidoId;
  String titulo;
  double preco;
  int quantidade;

  _ItemDTO({
    this.id,
    this.checked = true,
    this.produtoId,
    this.pedidoId,
    this.titulo,
    this.preco,
    this.quantidade = 1,
  });

  Map<String, dynamic> toJson() {
    final json = Map<String, dynamic>();
    json['id'] = this.id;
    json['checked'] = this.checked;
    json['produtoId'] = this.produtoId;
    json['pedidoId'] = this.pedidoId;
    json['titulo'] = this.titulo;
    json['preco'] = this.preco;
    json['quantidade'] = this.quantidade;

    return json;
  }
}
