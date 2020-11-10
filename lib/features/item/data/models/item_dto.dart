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
}
