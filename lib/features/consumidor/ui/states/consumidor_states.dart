abstract class ConsumidorState {}
class ConsumidorIdleState implements ConsumidorState {}
class ConsumidorCreatedState implements ConsumidorState {}
class ConsumidorErrorState implements ConsumidorState {
  final String message;

  ConsumidorErrorState(this.message);
}