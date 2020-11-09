import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:kommando/core/api/api_services.dart';
import 'package:kommando/core/api/message.dart';
import 'package:kommando/core/produto/models/produto.dart';
import 'package:kommando/features/produto/data/i_produto.dart';

class ProdutoServices implements IProduto {
  final ApiServices _services = ApiServices();

  @override
  Future deleteProdutoById({String id}) async {
    final Response _response = await _services.delete(uri: "/produtos", id: id);
    switch (_response.statusCode) {
      case HttpStatus.ok:
        return Message(jsonDecode(utf8.decode(_response.bodyBytes))['id']);
        break;
      default:
        return Message(jsonDecode(utf8.decode(_response.bodyBytes)));
    }
  }

  @override
  Future fetchProduto({String id}) async {
    final _response = await _services.get(uri: "/produtos/$id");
    switch (_response.statusCode) {
      case HttpStatus.ok:
        return Produto.fromJson(
            jsonDecode(utf8.decode(_response.bodyBytes))['produto']);
        break;
      default:
        return Message(jsonDecode(utf8.decode(_response.bodyBytes))['message']);
        break;
    }
  }

  @override
  Future fetchProdutos() async {
    final _response = await _services.get(uri: "/produtos");
    switch (_response.statusCode) {
      case HttpStatus.ok:
        final produtos =
            jsonDecode(utf8.decode(_response.bodyBytes))["produtos"];
        final list = List<Produto>();
        for (var lobby in produtos) {
          list.add(Produto.fromJson(lobby));
        }
        return list;
        break;
      default:
        return Message(jsonDecode(utf8.decode(_response.bodyBytes))['message']);
        break;
    }
  }

  @override
  Future updateProduto({Produto produto}) async {
    final Response _response =
        await _services.patch(uri: "/produtos", body: produto);
    switch (_response.statusCode) {
      case HttpStatus.ok:
        return Produto.fromJson(
            jsonDecode(utf8.decode(_response.bodyBytes))['produto']);
        break;
      default:
        return Message(jsonDecode(utf8.decode(_response.bodyBytes)));
        break;
    }
  }

  @override
  Future pushProduto({Produto produto}) async {
    final Response _response =
        await _services.post(uri: "/produtos", body: produto);
    switch (_response.statusCode) {
      case HttpStatus.created:
        return Produto.fromJson(
            jsonDecode(utf8.decode(_response.bodyBytes))['produto']);
        break;
      default:
        return Message(jsonDecode(utf8.decode(_response.bodyBytes)));
        break;
    }
  }
}
