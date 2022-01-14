import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lost_and_found/src/chat/message.dart';

class MessageService {
  void onSendMessage({required String gropChatId, required Message message}) {
    var documentReference = FirebaseFirestore.instance
        .collection("messages")
        .doc(gropChatId)
        .collection(gropChatId)
        .doc(DateTime.now().millisecondsSinceEpoch.toString());

    FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.set(
        documentReference,
        message.toHasMap(),
      );
    });
  }

  Message _messageFromSnaphot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot) {
    var data = snapshot.data();
    if (data == null) throw Exception("message not found");
    return Message.fromHasMap(data);
  }

  List<Message> _messageListFromSnaphots(
      QuerySnapshot<Map<String, dynamic>> snapshot) {
    return snapshot.docs.map((doc) {
      return _messageFromSnaphot(doc);
    }).toList();
  }

  Stream<List<Message>> getMessages(String groupChatId, int limit) {
    return FirebaseFirestore.instance
        .collection("messages")
        .doc(groupChatId)
        .collection(groupChatId)
        .orderBy("timestamp", descending: true)
        .limit(limit)
        .snapshots()
        .map(_messageListFromSnaphots);
  }
}
