import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference users() {
    return _firestore.collection("user");
  }
  
}