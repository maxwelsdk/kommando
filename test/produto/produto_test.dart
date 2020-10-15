import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kommando/core/api/api.dart';
import 'package:kommando/core/produto/models/produto.dart';
import 'package:kommando/features/produto/data/services/produto_services.dart';

void main() {
  Api.url = "http://localhost:8080";

  final ProdutoServices produtoServices = ProdutoServices();

  test("Atualiza dados de um produto", () async {
    await produtoServices
        .pushProduto(
            produto:
                Produto(descricao: "produto de teste", codigo: 99, preco: 9.99))
        .then((value) async {
      if (value is Produto) {
        value.descricao = "atualizado";
        return produtoServices.updateProduto(produto: value);
      }
    }).then((value) {
      expect(value.descricao, "atualizado");
      return value;
    }).then((value) => produtoServices.deleteProdutoById(id: value.id));
  });

  test("Criação, busca única de produto", () async {
    final produtoCreated = await produtoServices.pushProduto(
        produto:
            Produto(descricao: "produto de teste", codigo: 99, preco: 9.99));
    if (produtoCreated is Produto) {
      await produtoServices
          .fetchProduto(id: produtoCreated.id)
          .then((value) async {
        expect(value.id, produtoCreated.id);
        return value;
      }).then((value) async => await produtoServices
              .deleteProdutoById(id: value.id)
              .then((deleteResponse) => expect(value.id, deleteResponse)));
    }
  });

  test("Criação e deleção de produto", () async {
    await produtoServices
        .pushProduto(
            produto:
                Produto(descricao: "produto de teste", codigo: 99, preco: 9.99))
        .then((value) async {
      expect(value.id, isNotEmpty);
      await produtoServices
          .deleteProdutoById(id: value.id)
          .then((deleteResponse) => expect(value.id, deleteResponse));
    });
  });

  test("Criar lista, validar retorno de listas e deletar produtos testados ",
      () async {
    final list = List.generate(
        2,
        (index) => Produto(
            descricao: "produto de teste $index", codigo: 99, preco: 9.99));

    list.forEach((element) {
      produtoServices
          .pushProduto(produto: element)
          .then((value) => expect(value.id, isNotEmpty));
    });

    final listOfProdutos = await produtoServices.fetchProdutos();

    if (listOfProdutos is List<Produto>) {
      expect(listOfProdutos, isList);
      listOfProdutos.forEach((element) async {
        if (element.id != "5f88735b376ec738d20e7c91")
          await produtoServices.deleteProdutoById(id: element.id);
      });
    }
  });
}
