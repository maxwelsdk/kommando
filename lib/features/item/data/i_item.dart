import 'package:kommando/core/item/models/item.dart';

abstract class IItem {
  Future pushItem({Item item});
  Future fetchItens();
  Future fetchItem({String id});
  Future deleteItem({String id});
}