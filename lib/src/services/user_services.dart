import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  CollectionReference users = FirebaseFirestore.instance.collection("users");
  updateAccount(String id, Map<String, dynamic> data) {
    return users.doc(id).set(data, SetOptions(merge: true));
  }
}
