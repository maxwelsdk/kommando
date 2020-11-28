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

  _MyItemStore() {
    autorun((_) {
      print("auto roudou-se");
      if (state is ItemIdleState) {
        this.clearStore();
      }
    });
  }

  @observable
  ItemState state = ItemIdleState();

  @action
  ItemState setState(ItemState value) => this.state = value;

  @observable
  Item item = Item();

  @observable
  ObservableList<ItemDTO> pedidos = ObservableList();

  @observable
  ObservableList<ItemDTO> pedidosDesconhecidos = ObservableList();

  @computed
  bool get checkedPedidos {
    int i = 0;
    pedidosDesconhecidos.forEach((element) {
      if (element.checked) i++;
    });
    return i > 0;
  }

  @action
  void clearStore() {
    this.item = Item();
    this.pedidos.clear();
    this.pedidosDesconhecidos.clear();
  }

  @action
  addPedido({ItemDTO itemDTO}) {
    this.pedidos.add(itemDTO);
  }

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

  Future<void> pushItens({String pedidoId, List<Item> itens}) async {
    setState(ItemPushingState());
    final _itensResponse =
        await _itemServices.pushItens(pedidoId: pedidoId, itens: itens);
    if (_itensResponse is List<Item>) {
      setState(ItemCreatedState());
    }
    if (_itensResponse is Message) {
      setState(ItemErrorState());
    }
  }

  Future<void> pushItem({String pedidoId, Item item}) async {
    setState(ItemPushingState());
    final _itemResponse =
        await _itemServices.pushItem(pedidoId: pedidoId, item: item);
    if (_itemResponse is Message) {
      setState(ItemErrorState());
    }
    if (_itemResponse is Item) {
      setState(ItemCreatedState());
    }
  }

  @computed
  double get getTotalAcumuladoPedido {
    double total = 0.0;
    this.pedidos.forEach((element) {
      if (element.checked) {
        total += element.quantidade * element.preco;
      }
    });
    return total;
  }
}
