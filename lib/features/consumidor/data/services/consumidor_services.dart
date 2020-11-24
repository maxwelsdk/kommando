import 'dart:convert';
import 'dart:io';

import 'package:kommando/core/api/api_services.dart';
import 'package:kommando/core/api/message.dart';
import 'package:kommando/core/consumidor/data/models/consumidor.dart';
import 'package:kommando/features/consumidor/data/i_consumidor.dart';

class ConsumidorServices implements IConsumidor {
  ApiServices _services = ApiServices();

  @override
  Future fetchConsumidores({String lobbyId}) async {
    final _response =
        await _services.get(uri: "/lobbies/$lobbyId/consumidores");
    switch (_response.statusCode) {
      case HttpStatus.ok:
        final json =
            jsonDecode(utf8.decode(_response.bodyBytes))["consumidores"];
        final consumidores = List<Consumidor>();
        for (var j in json) {
          consumidores.add(Consumidor.fromJson(j));
        }
        return consumidores;
        break;
      default:
        return Message(jsonDecode(utf8.decode(_response.bodyBytes))['message']);
        break;
    }
  }

  @override
  Future pushConsumidor({Consumidor consumidor}) async {
    final _response =
        await _services.post(uri: "/consumidores", body: consumidor);
    switch (_response.statusCode) {
      case HttpStatus.created:
        return Consumidor.fromJson(
            jsonDecode(utf8.decode(_response.bodyBytes))["consumidor"]);
        break;
      default:
        return Message(jsonDecode(utf8.decode(_response.bodyBytes))['message']);
        break;
    }
  }

  @override
  Future deleteConsumidor({String id}) async {
    final _response = await _services.delete(uri: "/consumidores", id: id);
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
  Future fetchConsumidor({String consumidorId}) async {
    final _response = await _services.post(uri: "/consumidores/$consumidorId");
    switch (_response.statusCode) {
      case HttpStatus.ok:
        return Consumidor.fromJson(
            jsonDecode(utf8.decode(_response.bodyBytes))["consumidor"]);
        break;
      default:
        return Message(jsonDecode(utf8.decode(_response.bodyBytes))['message']);
        break;
    }
  }
}
