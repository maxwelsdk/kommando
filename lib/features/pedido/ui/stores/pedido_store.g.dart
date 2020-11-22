// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pedido_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PedidoStore on _PedidoStore, Store {
  final _$stateAtom = Atom(name: '_PedidoStore.state');

  @override
  PedidoState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(PedidoState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  final _$pedidoRealizadoStateAtom =
      Atom(name: '_PedidoStore.pedidoRealizadoState');

  @override
  ItensPedidosState get pedidoRealizadoState {
    _$pedidoRealizadoStateAtom.reportRead();
    return super.pedidoRealizadoState;
  }

  @override
  set pedidoRealizadoState(ItensPedidosState value) {
    _$pedidoRealizadoStateAtom.reportWrite(value, super.pedidoRealizadoState,
        () {
      super.pedidoRealizadoState = value;
    });
  }

  final _$_PedidoStoreActionController = ActionController(name: '_PedidoStore');

  @override
  PedidoState setState(PedidoState value) {
    final _$actionInfo = _$_PedidoStoreActionController.startAction(
        name: '_PedidoStore.setState');
    try {
      return super.setState(value);
    } finally {
      _$_PedidoStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  ItensPedidosState setPedidoRealizadoState(ItensPedidosState value) {
    final _$actionInfo = _$_PedidoStoreActionController.startAction(
        name: '_PedidoStore.setPedidoRealizadoState');
    try {
      return super.setPedidoRealizadoState(value);
    } finally {
      _$_PedidoStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
state: ${state},
pedidoRealizadoState: ${pedidoRealizadoState}
    ''';
  }
}
