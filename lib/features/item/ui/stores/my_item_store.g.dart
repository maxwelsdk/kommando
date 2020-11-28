// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_item_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MyItemStore on _MyItemStore, Store {
  Computed<bool> _$checkedPedidosComputed;

  @override
  bool get checkedPedidos =>
      (_$checkedPedidosComputed ??= Computed<bool>(() => super.checkedPedidos,
              name: '_MyItemStore.checkedPedidos'))
          .value;
  Computed<double> _$getTotalAcumuladoPedidoComputed;

  @override
  double get getTotalAcumuladoPedido => (_$getTotalAcumuladoPedidoComputed ??=
          Computed<double>(() => super.getTotalAcumuladoPedido,
              name: '_MyItemStore.getTotalAcumuladoPedido'))
      .value;

  final _$stateAtom = Atom(name: '_MyItemStore.state');

  @override
  ItemState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(ItemState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  final _$itemAtom = Atom(name: '_MyItemStore.item');

  @override
  Item get item {
    _$itemAtom.reportRead();
    return super.item;
  }

  @override
  set item(Item value) {
    _$itemAtom.reportWrite(value, super.item, () {
      super.item = value;
    });
  }

  final _$pedidosAtom = Atom(name: '_MyItemStore.pedidos');

  @override
  ObservableList<ItemDTO> get pedidos {
    _$pedidosAtom.reportRead();
    return super.pedidos;
  }

  @override
  set pedidos(ObservableList<ItemDTO> value) {
    _$pedidosAtom.reportWrite(value, super.pedidos, () {
      super.pedidos = value;
    });
  }

  final _$pedidosDesconhecidosAtom =
      Atom(name: '_MyItemStore.pedidosDesconhecidos');

  @override
  ObservableList<ItemDTO> get pedidosDesconhecidos {
    _$pedidosDesconhecidosAtom.reportRead();
    return super.pedidosDesconhecidos;
  }

  @override
  set pedidosDesconhecidos(ObservableList<ItemDTO> value) {
    _$pedidosDesconhecidosAtom.reportWrite(value, super.pedidosDesconhecidos,
        () {
      super.pedidosDesconhecidos = value;
    });
  }

  final _$_MyItemStoreActionController = ActionController(name: '_MyItemStore');

  @override
  ItemState setState(ItemState value) {
    final _$actionInfo = _$_MyItemStoreActionController.startAction(
        name: '_MyItemStore.setState');
    try {
      return super.setState(value);
    } finally {
      _$_MyItemStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearStore() {
    final _$actionInfo = _$_MyItemStoreActionController.startAction(
        name: '_MyItemStore.clearStore');
    try {
      return super.clearStore();
    } finally {
      _$_MyItemStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic addPedido({ItemDTO itemDTO}) {
    final _$actionInfo = _$_MyItemStoreActionController.startAction(
        name: '_MyItemStore.addPedido');
    try {
      return super.addPedido(itemDTO: itemDTO);
    } finally {
      _$_MyItemStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic minusQuantidade() {
    final _$actionInfo = _$_MyItemStoreActionController.startAction(
        name: '_MyItemStore.minusQuantidade');
    try {
      return super.minusQuantidade();
    } finally {
      _$_MyItemStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic plusQuantidade() {
    final _$actionInfo = _$_MyItemStoreActionController.startAction(
        name: '_MyItemStore.plusQuantidade');
    try {
      return super.plusQuantidade();
    } finally {
      _$_MyItemStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
state: ${state},
item: ${item},
pedidos: ${pedidos},
pedidosDesconhecidos: ${pedidosDesconhecidos},
checkedPedidos: ${checkedPedidos},
getTotalAcumuladoPedido: ${getTotalAcumuladoPedido}
    ''';
  }
}
