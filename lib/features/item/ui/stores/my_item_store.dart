import 'package:kommando/core/item/models/item.dart';
import 'package:mobx/mobx.dart';

part 'my_item_store.g.dart';

class MyItemStore = _MyItemStore with _$MyItemStore;

abstract class _MyItemStore with Store {
  @observable
  Item item = Item();

  @action
  minusQuantidade() {
    if (item.quantidade > 1) {
      item.quantidade--;
    }
  }

  @action
  plusQuantidade() {
    item.quantidade++;
  }
}
