import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  CollectionReference users = FirebaseFirestore.instance.collection("users");
  updateAccount(String id, Map<String, dynamic> data) {
    return users.doc(id).set(data, SetOptions(merge: true));
  }

  Future<void> saveToken(String token, String uid) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .update({'token': token});
  }
}
