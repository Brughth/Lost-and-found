import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Objetservice {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference lostObjet =
      FirebaseFirestore.instance.collection("lost_objet");

  CollectionReference foundObjet =
      FirebaseFirestore.instance.collection("found_objet");

  Future<DocumentReference<Object?>> saveObjet(
      Map<String, dynamic> data, bool isLost) {
    data["createdAt"] = DateTime.now().toUtc().toIso8601String();
    if (isLost) {
      return lostObjet.add(data);
    } else {
      return foundObjet.add(data);
    }
  }

  Future<String> uploadFileToFireStorage(File file, String name) async {
    var ref = FirebaseStorage.instance.ref(name); // i don't no

    var uploadedFile = await ref.putFile(file);
    return await uploadedFile.ref.getDownloadURL();
  }
}
