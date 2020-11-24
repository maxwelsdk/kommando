import 'package:kommando/core/consumidor/data/models/consumidor.dart';

abstract class IConsumidor {
  Future pushConsumidor({Consumidor consumidor});
  Future fetchConsumidores({String lobbyId});
  Future fetchConsumidor({String consumidorId});
  Future deleteConsumidor({String id});
}