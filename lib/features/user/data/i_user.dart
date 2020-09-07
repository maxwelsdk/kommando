import 'package:cloud_firestore/cloud_firestore.dart';

abstract class IUser {
  CollectionReference users();
  Future<QuerySnapshot> currentUserPersonalData({String uid});
}