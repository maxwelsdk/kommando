import 'package:kommando/core/consumidor/data/models/consumidor.dart';

abstract class ConsumidorState {}
class ConsumidorIdleState implements ConsumidorState {}
class ConsumidorCreatedState implements ConsumidorState {
  final Consumidor consumidor;

  ConsumidorCreatedState(this.consumidor);
}
class ConsumidorErrorState implements ConsumidorState {
  final String message;

  ConsumidorErrorState(this.message);
}