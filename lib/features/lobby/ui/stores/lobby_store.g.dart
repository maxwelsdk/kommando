// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lobby_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LobbyStore on _LobbyStore, Store {
  final _$stateAtom = Atom(name: '_LobbyStore.state');

  @override
  LobbyState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(LobbyState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  final _$_LobbyStoreActionController = ActionController(name: '_LobbyStore');

  @override
  LobbyState setState(LobbyState value) {
    final _$actionInfo =
        _$_LobbyStoreActionController.startAction(name: '_LobbyStore.setState');
    try {
      return super.setState(value);
    } finally {
      _$_LobbyStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
state: ${state}
    ''';
  }
}
