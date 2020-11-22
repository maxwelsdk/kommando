import 'package:kommando/core/item/models/item.dart';

abstract class ItensPedidosState {}
class ItensPedidosIdleState implements ItensPedidosState {}
class ItensPedidosLoadingState implements ItensPedidosState {}
class ItensPedidosErrorState implements ItensPedidosState {
  final String message;

  ItensPedidosErrorState(this.message);
}
class ItensPedidosFoundState implements ItensPedidosState {
  final List<Item> itens;

  ItensPedidosFoundState(this.itens);
}