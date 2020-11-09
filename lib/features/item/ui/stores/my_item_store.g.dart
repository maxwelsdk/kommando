// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_item_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MyItemStore on _MyItemStore, Store {
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

  final _$_MyItemStoreActionController = ActionController(name: '_MyItemStore');

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
item: ${item}
    ''';
  }
}
