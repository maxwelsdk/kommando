import 'package:kommando/core/pedido/models/pedido.dart';

abstract class PedidoState {}

class PedidoIdleState implements PedidoState {}
class PedidoPushingState implements PedidoState {}
class PedidoSucessState implements PedidoState {
  final Pedido pedido;

  PedidoSucessState(this.pedido);
}
class PedidoErrorState implements PedidoState {
  final String message;

  PedidoErrorState(this.message);
}