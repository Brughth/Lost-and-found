import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  CollectionReference users = FirebaseFirestore.instance.collection("users");
  updateAccount(String id, Map<String, dynamic> data) {
    return users.doc(id).set(data, SetOptions(merge: true));
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUser(String userId) {
    return FirebaseFirestore.instance.collection("users").doc(userId).get();
  }

  Future<void> saveToken(String token, String uid) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .update({'token': token});
  }
}
