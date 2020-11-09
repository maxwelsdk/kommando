abstract class PedidoState {}

class PedidoIdleState implements PedidoState {}
class PedidoPushingState implements PedidoState {}
class PedidoSucessState implements PedidoState {}
class PedidoErrorState implements PedidoState {
  final String message;

  PedidoErrorState(this.message);
}