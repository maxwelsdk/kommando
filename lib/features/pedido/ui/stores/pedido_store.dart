import 'package:kommando/core/api/message.dart';
import 'package:kommando/core/item/models/item.dart';
import 'package:kommando/core/pedido/models/pedido.dart';
import 'package:kommando/features/pedido/data/services/pedido_services.dart';
import 'package:kommando/features/pedido/ui/states/pedido_realizados_state.dart';
import 'package:kommando/features/pedido/ui/states/pedido_states.dart';
import 'package:mobx/mobx.dart';

part 'pedido_store.g.dart';

class PedidoStore = _PedidoStore with _$PedidoStore;

abstract class _PedidoStore with Store {
  final PedidoServices _pedidoServices = PedidoServices();

  @observable
  PedidoState state = PedidoIdleState();

  @action
  PedidoState setState(PedidoState value) => this.state = value;

  @observable
  ItensPedidosState pedidoRealizadoState = ItensPedidosIdleState();

  @action
  ItensPedidosState setPedidoRealizadoState(ItensPedidosState value) =>
      this.pedidoRealizadoState = value;

  Future<PedidoState> pushPedido({Pedido pedido}) async {
    setState(PedidoPushingState());
    final _responsePedido = await _pedidoServices.pushPedido(pedido: pedido);
    if (_responsePedido is Message) {
      setState(PedidoErrorState(_responsePedido.message));
    }
    if (_responsePedido is Pedido) {
      setState(PedidoSucessState(_responsePedido));
    }
    return state;
  }

  Future<PedidoState> getPedido({String id}) async {
    setState(PedidoPushingState());
    final _responsePedido = await _pedidoServices.fetchPedido(id: id);
    if (_responsePedido is Message) {
      setState(PedidoErrorState(_responsePedido.message));
    }
    if (_responsePedido is Pedido) {
      setState(PedidoSucessState(_responsePedido));
    }
    return state;
  }

  Future<PedidoState> updatePedido({Pedido pedido}) async {
    setState(PedidoPushingState());
    final _responsePedido = await _pedidoServices.updatePedido(pedido: pedido);
    if (_responsePedido is Message) {
      setState(PedidoErrorState(_responsePedido.message));
    }
    if (_responsePedido is Pedido) {
      setState(PedidoSucessState(_responsePedido));
    }
    return state;
  }

  Future<void> getPedidosByLobbyAndConsumidor(
      {String lobbyId, String consumidorId}) async {
    setPedidoRealizadoState(ItensPedidosLoadingState());
    final _responsePedidos =
        await _pedidoServices.fetchPedidosByLobbyAndConsumidor(
            lobbyId: lobbyId, consumidorId: consumidorId);

    if (_responsePedidos is Message) {
      setPedidoRealizadoState(ItensPedidosErrorState(_responsePedidos.message));
    }
    if (_responsePedidos is List<Item>) {
      setPedidoRealizadoState(ItensPedidosFoundState(_responsePedidos));
    }
  }

  Future<void> getPedidosDesconhecidosByLobby({String lobbyId}) async {
    setPedidoRealizadoState(ItensPedidosLoadingState());
    final _responsePedidos = await _pedidoServices
        .fetchPedidosDesconhecidosByLobby(lobbyId: lobbyId);

    if (_responsePedidos is Message) {
      setPedidoRealizadoState(ItensPedidosErrorState(_responsePedidos.message));
    }
    if (_responsePedidos is List<Item>) {
      setPedidoRealizadoState(ItensPedidosFoundState(_responsePedidos));
    }
  }
}
