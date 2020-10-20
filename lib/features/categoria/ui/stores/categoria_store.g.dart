// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categoria_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CategoriaStore on _CategoriaStore, Store {
  final _$stateAtom = Atom(name: '_CategoriaStore.state');

  @override
  CategoriaState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(CategoriaState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  final _$_CategoriaStoreActionController =
      ActionController(name: '_CategoriaStore');

  @override
  CategoriaState setState(CategoriaState value) {
    final _$actionInfo = _$_CategoriaStoreActionController.startAction(
        name: '_CategoriaStore.setState');
    try {
      return super.setState(value);
    } finally {
      _$_CategoriaStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
state: ${state}
    ''';
  }
}
