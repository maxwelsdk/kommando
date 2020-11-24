import 'package:kommando/core/pedido/models/pedido.dart';

abstract class IPedido {
  Future fetchPedido({String id});
  Future fetchPedidos();
  Future fetchPedidosByLobbyAndConsumidor({String lobbyId, String consumidorId});
  Future fetchPedidosDesconhecidosByLobby({String lobbyId});
  Future pushPedido({Pedido pedido});
  Future updatePedido({Pedido pedido});
  Future deletePedido({String id});
}