// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'consumidor_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ConsumidorStore on _ConsumidorStore, Store {
  final _$stateAtom = Atom(name: '_ConsumidorStore.state');

  @override
  ConsumidorState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(ConsumidorState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  final _$_ConsumidorStoreActionController =
      ActionController(name: '_ConsumidorStore');

  @override
  ConsumidorState setState(ConsumidorState value) {
    final _$actionInfo = _$_ConsumidorStoreActionController.startAction(
        name: '_ConsumidorStore.setState');
    try {
      return super.setState(value);
    } finally {
      _$_ConsumidorStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
state: ${state}
    ''';
  }
}
