import 'package:kommando/core/produto/models/produto.dart';
import 'package:kommando/features/produto/data/services/produto_services.dart';
import 'package:mobx/mobx.dart';

part 'produto_store.g.dart';

class ProdutoStore = _ProdutoStore with _$ProdutoStore;

abstract class _ProdutoStore with Store {
  final ProdutoServices _produtoServices = ProdutoServices();

  Future<Produto> getProduto({String id}) async {
    return await _produtoServices.fetchProduto(id: id);
  }
}
