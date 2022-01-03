import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Objetservice {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference lostObjet =
      FirebaseFirestore.instance.collection("lost_objet");

  Future<DocumentReference<Object?>> saveObjet(Map<String, dynamic> data) {
    data["createdAt"] = DateTime.now().toUtc().toIso8601String();
    return lostObjet.add(data);
  }

  Future<String> uploadFileToFireStorage(File file, String name) async {
    var ref = FirebaseStorage.instance.ref(name); // i don't no

    var uploadedFile = await ref.putFile(file);
    return await uploadedFile.ref.getDownloadURL();
  }
}
