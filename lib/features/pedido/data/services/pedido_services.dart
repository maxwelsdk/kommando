import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:kommando/core/api/api_services.dart';
import 'package:kommando/core/api/message.dart';
import 'package:kommando/core/item/models/item.dart';

import 'package:kommando/core/pedido/models/pedido.dart';
import 'package:kommando/features/pedido/data/i_pedido.dart';

class PedidoServices implements IPedido {
  final ApiServices _apiServices = ApiServices();

  @override
  Future deletePedido({String id}) async {
    final Response _response =
        await _apiServices.delete(uri: "/pedidos", id: id);
    switch (_response.statusCode) {
      case HttpStatus.ok:
        return Message(jsonDecode(utf8.decode(_response.bodyBytes))['id']);
        break;
      default:
        return Message(jsonDecode(utf8.decode(_response.bodyBytes))['message']);
    }
  }

  @override
  Future fetchPedido({String id}) async {
    final Response _response = await _apiServices.get(uri: "/pedidos/$id");
    switch (_response.statusCode) {
      case HttpStatus.ok:
        return Pedido.fromJson(
            jsonDecode(utf8.decode(_response.bodyBytes))['pedido']);
        break;
      default:
        return Message(jsonDecode(utf8.decode(_response.bodyBytes))['message']);
    }
  }

  @override
  Future fetchPedidos() async {
    final Response _response = await _apiServices.get(uri: "/pedidos");
    switch (_response.statusCode) {
      case HttpStatus.ok:
        final pedidos = List<Pedido>();
        final json = jsonDecode(utf8.decode(_response.bodyBytes))['pedidos'];
        for (Object j in json) {
          pedidos.add(Pedido.fromJson(j));
        }
        return pedidos;
        break;
      default:
        return Message(jsonDecode(utf8.decode(_response.bodyBytes))['message']);
    }
  }

  @override
  Future pushPedido({Pedido pedido}) async {
    final Response _response =
        await _apiServices.post(uri: "/pedidos", body: pedido);
    switch (_response.statusCode) {
      case HttpStatus.created:
        return Pedido.fromJson(
            jsonDecode(utf8.decode(_response.bodyBytes))['pedido']);
        break;
      default:
        return Message(jsonDecode(utf8.decode(_response.bodyBytes))['message']);
        break;
    }
  }

  @override
  Future updatePedido({Pedido pedido}) async {
    final Response _response =
        await _apiServices.patch(uri: "/pedidos", body: pedido);
    switch (_response.statusCode) {
      case HttpStatus.ok:
        return Pedido.fromJson(
            jsonDecode(utf8.decode(_response.bodyBytes))['pedido']);
        break;
      default:
        return Message(jsonDecode(utf8.decode(_response.bodyBytes))['message']);
        break;
    }
  }

  @override
  Future fetchPedidosByLobbyAndConsumidor(
      {String lobbyId, String consumidorId}) async {
    try {
      final Response _response = await _apiServices.get(
        uri: "/pedidos/$lobbyId/$consumidorId",
      );
      switch (_response.statusCode) {
        case HttpStatus.ok:
          final itens = List<Item>();
          final json = jsonDecode(utf8.decode(_response.bodyBytes))['itens'];
          for (Object j in json) {
            itens.add(Item.fromJson(j));
          }
          return itens;
        default:
          return Message(
              jsonDecode(utf8.decode(_response.bodyBytes))['message']);
          break;
      }
    } catch (e, s) {
      print(s);
      return Message(e);
    }
  }

  @override
  Future fetchPedidosDesconhecidosByLobby({String lobbyId}) async {
    try {
      final Response _response = await _apiServices.get(
        uri: "/pedidos/desconhecidos/$lobbyId",
      );
      switch (_response.statusCode) {
        case HttpStatus.ok:
          final itens = List<Item>();
          final json = jsonDecode(utf8.decode(_response.bodyBytes))['itens'];
          for (Object j in json) {
            itens.add(Item.fromJson(j));
          }
          return itens;
        default:
          return Message(
              jsonDecode(utf8.decode(_response.bodyBytes))['message']);
          break;
      }
    } catch (e, s) {
      print(s);
      return Message(e);
    }
  }
}
