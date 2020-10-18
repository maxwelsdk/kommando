import 'package:flutter_test/flutter_test.dart';
import 'package:kommando/core/api/api.dart';
import 'package:kommando/core/item/models/item.dart';
import 'package:kommando/features/item/data/services/item_services.dart';

void main() {
  Api.url = "http://localhost:8080";

  ItemServices _itemServices = ItemServices();

  test("Cria e deleta item", () async {
    await _itemServices
        .pushItem(
            item: Item(produtoId: "5f88735b376ec738d20e7c91", quantidade: 1))
        .then((value) {
      expect(value.produtoId, "5f88735b376ec738d20e7c91");
      return value;
    }).then((item) async {
      if (item is Item)
        await _itemServices
            .deleteItem(id: item.id)
            .then((value) => expect(value.message, item.id));
    });
  });

  test("Cria um item teste, valida busca", () async {
    await _itemServices
        .pushItem(
            item: Item(produtoId: "5f88735b376ec738d20e7c91", quantidade: 10))
        .then((itemCreated) {
      if (itemCreated is Item) {
        expect(itemCreated.id, isNotEmpty);
        expect(itemCreated.produtoId, "5f88735b376ec738d20e7c91");
        return itemCreated;
      }
    }).then((itemCreated) async {
      await _itemServices
          .fetchItem(id: itemCreated.id)
          .then((value) => expect(value.id, itemCreated.id));
      return itemCreated;
    }).then((value) => _itemServices.deleteItem(id: value.id));
  });

  test("Criar e busca lista, deleta para finalizar", () async {
    final listItem = List.generate(
        3,
        (index) =>
            Item(produtoId: "5f88735b376ec738d20e7c91", quantidade: index));

    for (var item in listItem) {
      await _itemServices
          .pushItem(item: item)
          .then((value) => expect(value.id, isNotEmpty));
    }

    final list = await _itemServices.fetchItens();

    if (list is List<Item>) {
      expect(list, isList);
      for (var item in list) {
        await _itemServices
            .deleteItem(id: item.id)
            .then((value) => expect(value.message, item.id));
      }
    }
  });
}
