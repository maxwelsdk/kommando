// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UserStore on _UserStore, Store {
  final _$stateAtom = Atom(name: '_UserStore.state');

  @override
  UserState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(UserState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  final _$_UserStoreActionController = ActionController(name: '_UserStore');

  @override
  UserState setState(UserState value) {
    final _$actionInfo =
        _$_UserStoreActionController.startAction(name: '_UserStore.setState');
    try {
      return super.setState(value);
    } finally {
      _$_UserStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
state: ${state}
    ''';
  }
}
