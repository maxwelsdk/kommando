import 'dart:convert';
import 'dart:io';

import 'package:kommando/core/api/api_services.dart';
import 'package:kommando/core/api/message.dart';
import 'package:kommando/core/categoria/data/models/categoria.dart';
import 'package:kommando/features/categoria/data/i_categoria.dart';

class CategoriaServices implements ICategoria {
  ApiServices _apiServices = ApiServices();

  @override
  Future deleteCategoria({String id}) async {
    final _response = await _apiServices.delete(uri: "/categorias", id: id);
    switch (_response.statusCode) {
      case HttpStatus.ok:
        return Message(jsonDecode(utf8.decode(_response.bodyBytes))["id"]);
        break;
      default:
        return Message(jsonDecode(utf8.decode(_response.bodyBytes))['message']);
        break;
    }
  }

  @override
  Future fetchCategorias() async {
    final _response = await _apiServices.get(uri: "/categorias");
    switch (_response.statusCode) {
      case HttpStatus.ok:
        final categorias =
            jsonDecode(utf8.decode(_response.bodyBytes))["categorias"];
        final categoriasList = List<Categoria>();
        for (var categoria in categorias) {
          categoriasList.add(Categoria.fromJson(categoria));
        }
        return categoriasList;
        break;
      default:
        return Message(jsonDecode(utf8.decode(_response.bodyBytes))['message']);
        break;
    }
  }

  @override
  Future pushCategoria({Categoria categoria}) async {
    final _response =
        await _apiServices.post(uri: "/categorias", body: categoria);
    switch (_response.statusCode) {
      case HttpStatus.created:
        return Categoria.fromJson(
            jsonDecode(utf8.decode(_response.bodyBytes))['categoria']);
        break;
      default:
        return Message(jsonDecode(utf8.decode(_response.bodyBytes))['message']);
        break;
    }
  }

  @override
  Future updateCategoria({Categoria categoria}) async {
    final _response =
        await _apiServices.patch(uri: "/categorias", body: categoria);
    switch (_response.statusCode) {
      case HttpStatus.ok:
        return Categoria.fromJson(
            jsonDecode(utf8.decode(_response.bodyBytes))['categoria']);
        break;
      default:
        return Message(jsonDecode(utf8.decode(_response.bodyBytes))['message']);
        break;
    }
  }

  @override
  Future fetchCategoriaById({String id}) async {
    final _response = await _apiServices.get(uri: "/categorias/$id");
    switch (_response.statusCode) {
      case HttpStatus.ok:
        return Categoria.fromJson(
            jsonDecode(utf8.decode(_response.bodyBytes))["categoria"]);
        break;
      default:
        return Message(jsonDecode(utf8.decode(_response.bodyBytes))['message']);
        break;
    }
  }
}
