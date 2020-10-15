import 'package:kommando/core/produto/models/produto.dart';

abstract class IProduto {
  Future fetchProduto({String id});
  Future fetchProdutos();
  Future pushProduto({Produto produto});
  Future updateProduto({Produto produto});
  Future deleteProdutoById({String id});
}