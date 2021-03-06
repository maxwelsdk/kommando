import 'dart:convert';
import 'dart:io';

import 'package:kommando/core/api/api_services.dart';
import 'package:kommando/core/api/message.dart';
import 'package:kommando/core/item/models/item.dart';
import 'package:kommando/features/item/data/i_item.dart';
import 'package:http/http.dart';

class ItemServices implements IItem {
  final ApiServices _apiServices = ApiServices();

  @override
  Future deleteItem({String id}) async {
    final Response _response = await _apiServices.delete(uri: "/itens", id: id);
    switch (_response.statusCode) {
      case HttpStatus.ok:
        return Message(jsonDecode(utf8.decode(_response.bodyBytes))['id']);
        break;
      default:
        return Message(jsonDecode(utf8.decode(_response.bodyBytes))['message']);
    }
  }

  @override
  Future fetchItem({String id}) async {
    final Response _response = await _apiServices.get(uri: "/itens/$id");
    switch (_response.statusCode) {
      case HttpStatus.ok:
        final json = jsonDecode(utf8.decode(_response.bodyBytes))['item'];
        return Item.fromJson(json);
        break;
      default:
        return Message(jsonDecode(utf8.decode(_response.bodyBytes))['message']);
    }
  }

  @override
  Future fetchItens() async {
    final Response _response = await _apiServices.get(uri: "/itens");
    switch (_response.statusCode) {
      case HttpStatus.ok:
        final itens = List<Item>();
        final json = jsonDecode(utf8.decode(_response.bodyBytes))['itens'];
        for (Object j in json) {
          itens.add(Item.fromJson(j));
        }
        return itens;
        break;
      default:
        return Message(jsonDecode(utf8.decode(_response.bodyBytes))['message']);
    }
  }

  @override
  Future pushItem({String pedidoId, Item item}) async {
    final Response _response =
        await _apiServices.post(uri: "/itens/$pedidoId", body: item);
    switch (_response.statusCode) {
      case HttpStatus.created:
        return Item.fromJson(
            jsonDecode(utf8.decode(_response.bodyBytes))['item']);
        break;
      default:
        return Message(jsonDecode(utf8.decode(_response.bodyBytes))['message']);
    }
  }

  @override
  Future pushItens({String pedidoId, List<Item> itens}) async {
    try {
      final Response _response =
          await _apiServices.post(uri: "/itens/$pedidoId/batch", body: itens);
      switch (_response.statusCode) {
        case HttpStatus.created:
          List<Item> itens = List();
          final json = jsonDecode(utf8.decode(_response.bodyBytes))['itens'];
          for (var item in json) {
            itens.add(Item.fromJson(item));
          }
          return itens;
          break;
        default:
          return Message(jsonDecode(utf8.decode(_response.bodyBytes))['message']);
      }
    } catch (e, s) {
      print(s);
    }
  }
}
