import 'package:kommando/core/api/message.dart';
import 'package:kommando/core/pedido/models/pedido.dart';
import 'package:kommando/features/pedido/data/services/pedido_services.dart';
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
}
