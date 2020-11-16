import 'package:mobx/mobx.dart';

part 'item_dto.g.dart';

class ItemDTO = _ItemDTO with _$ItemDTO;

abstract class _ItemDTO with Store {
  @observable
  bool checked;
  String titulo;
  double preco;
  int quantidade;

  _ItemDTO({
    this.checked = true,
    this.titulo,
    this.preco,
    this.quantidade = 1,
  });

  Map<String, dynamic> toJson() {
    final json = Map<String, dynamic>();
    json['checked'] = this.checked;
    json['titulo'] = this.titulo;
    json['preco'] = this.preco;
    json['quantidade'] = this.quantidade;

    return json;
  }
}
