import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kommando/features/user/data/i_user.dart';

class UserServices implements IUser {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference users() {
    return _firestore.collection("users");
  }

  @override
  Future<QuerySnapshot> currentUserPersonalData({String uid}) {
    return _firestore
        .collection("users")
        .limit(1)
        .where('uid',
        isEqualTo: FirebaseAuth.instance.currentUser.uid)
        .get();
  }
  
}