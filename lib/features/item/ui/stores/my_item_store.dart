import 'package:kommando/core/api/message.dart';
import 'package:kommando/core/item/models/item.dart';
import 'package:kommando/features/item/data/models/item_dto.dart';
import 'package:kommando/features/item/data/services/item_services.dart';
import 'package:kommando/features/item/ui/states/item_states.dart';
import 'package:mobx/mobx.dart';

part 'my_item_store.g.dart';

class MyItemStore = _MyItemStore with _$MyItemStore;

abstract class _MyItemStore with Store {
  final ItemServices _itemServices = ItemServices();

  @observable
  ItemState state = ItemIdleState();

  @action
  ItemState setState(ItemState value) => this.state = value;

  @observable
  Item item = Item();

  @observable
  ObservableList<Item> itens = ObservableList();

  @observable
  ObservableList<ItemDTO> pedidos = ObservableList();

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

  Future<void> pushItem({String pedidoId, Item item}) async {
    setState(ItemPushingState());
    final _itemResponse =
        await _itemServices.pushItem(pedidoId: pedidoId, item: item);
    if (_itemResponse is Message) {
      setState(ItemErrorState());
    }
    if (_itemResponse is Item) {
      setState(ItemCreatedState(_itemResponse));
    }
  }

  double getTotalAcumuladoPedido() {
    double total = 0.0;
    this.pedidos.forEach((element) {
      if (element.checked) {
        total += element.quantidade * element.preco;
      }
    });
    return total;
  }
}
