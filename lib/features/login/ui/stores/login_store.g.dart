// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LoginStore on _LoginStore, Store {
  final _$stateAtom = Atom(name: '_LoginStore.state');

  @override
  LoginState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(LoginState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  final _$_LoginStoreActionController = ActionController(name: '_LoginStore');

  @override
  dynamic setState(LoginState value) {
    final _$actionInfo =
        _$_LoginStoreActionController.startAction(name: '_LoginStore.setState');
    try {
      return super.setState(value);
    } finally {
      _$_LoginStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
state: ${state}
    ''';
  }
}
