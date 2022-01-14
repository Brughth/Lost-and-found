class ChatParams {
  final String userId;
  final String peerId;
  final String peerName;

  ChatParams({
    required this.userId,
    required this.peerId,
    required this.peerName,
  });

  String getChatGroupId() {
    if (userId.hashCode <= peerId.hashCode) {
      return "$userId-$peerId";
    } else {
      return "$peerId-$userId";
    }
  }
}










































// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class Message {
//   String id;
//   String message;
//   String authorId;
//   DateTime createdAt;
//   DateTime? readAt;

//   Message(this.id, this.message, this.authorId, this.createdAt, this.readAt);

//   String get time => DateFormat('d/M, h:m a').format(DateTime.now());
//   bool get fromMe => authorId == FirebaseAuth.instance.currentUser!.uid;
// }

// class Chat {
//   String? conversationId;
//   String friendId;
//   String? friendUsername;
//   DateTime? updatedAt;
//   List<Message>? messages;
//   ValueNotifier<int> notifier = ValueNotifier(0);
//   bool isOpen = false;

//   Chat(
//     this.friendId, {
//     this.conversationId,
//     this.updatedAt,
//     this.friendUsername,
//     this.messages,
//   });

//   int get unreadMessagesCount {
//     return messages
//             ?.where((e) => e.authorId == friendId && e.readAt == null)
//             .length ??
//         0;
//   }

//   Future<String> fetchFriendUsername() async {
//     if (friendUsername == null) {
//       DocumentSnapshot<Map<String, dynamic>> result = await FirebaseFirestore
//           .instance
//           .collection('users')
//           .doc(friendId)
//           .get();
//       friendUsername = result.data()!['username'];
//     }
//     return friendUsername!;
//   }

//   Future<void> fetchMessages() async {
//     CollectionReference<Map<String, dynamic>> collection =
//         FirebaseFirestore.instance.collection('messages');
//     late QuerySnapshot<Map<String, dynamic>> result;
//     if (messages == null) {
//       result = await collection
//           .where('conversationId', isEqualTo: conversationId)
//           .get();
//       messages = result.docs.map((e) {
//         Map data = e.data();
//         return Message(
//           e.id,
//           data['message'],
//           e['authorId'],
//           (e['createdAt'] as Timestamp).toDate(),
//           (e['readAt'] as Timestamp?)?.toDate(),
//         );
//       }).toList();
//       messages!.sort((a, b) => a.createdAt.compareTo(b.createdAt));
//     } else {
//       List<Message> toReadMessages =
//           messages!.where((e) => e.fromMe && e.readAt == null).toList();
//       if (toReadMessages.isNotEmpty) {
//         result = await collection
//             .where('conversationId', isEqualTo: conversationId)
//             .where(FieldPath.documentId,
//                 whereIn: toReadMessages.map((e) => e.id).toList())
//             .get();
//       } else {
//         result = await collection
//             .where('conversationId', isEqualTo: conversationId)
//             .where('readAt', isNull: true)
//             .get();
//       }
//       List<Message> temp = result.docs.map((e) {
//         Map data = e.data();
//         return Message(
//           e.id,
//           data['message'],
//           e['authorId'],
//           (e['createdAt'] as Timestamp).toDate(),
//           (e['readAt'] as Timestamp?)?.toDate(),
//         );
//       }).toList();
//       print(temp);
//       temp.sort((a, b) => a.createdAt.compareTo(b.createdAt));
//       messages!.removeWhere((e) => e.fromMe && e.readAt == null);
//       messages!.addAll(temp);
//     }
//     print(messages!.map((e) => '${e.message} | ${e.readAt == null}'));
//     if (isOpen) markAsRead();
//     notifier.value = DateTime.now().millisecondsSinceEpoch;
//   }

//   Future<void> sendMessage(String newMessage) async {
//     if (newMessage.isEmpty) return;
//     User user = FirebaseAuth.instance.currentUser!;
//     Timestamp now = Timestamp.now();
//     if (conversationId == null) {
//       DocumentReference<Map<String, dynamic>> doc =
//           await FirebaseFirestore.instance.collection('conversations').add({
//         'members': [friendId, user.uid],
//         'updatedAt': Timestamp.now()
//       });
//       conversationId = doc.id;
//     }
//     DocumentReference<Map<String, dynamic>> doc =
//         await FirebaseFirestore.instance.collection('messages').add({
//       'message': newMessage,
//       'authorId': user.uid,
//       'createdAt': now,
//       'readAt': null,
//       'conversationId': conversationId,
//     });
//     conversationUpdated();
//     messages!.add(Message(doc.id, newMessage, user.uid, now.toDate(), null));
//   }

//   Future<void> markAsRead() async {
//     if (unreadMessagesCount > 0) {
//       CollectionReference<Map<String, dynamic>> collection =
//           FirebaseFirestore.instance.collection('messages');
//       Timestamp now = Timestamp.now();
//       WriteBatch batch = FirebaseFirestore.instance.batch();
//       QuerySnapshot<Map<String, dynamic>> snapshot = await collection
//           .where('conversationId', isEqualTo: conversationId)
//           .where('authorId', isEqualTo: friendId)
//           .where('readAt', isNull: true)
//           .get();
//       snapshot.docs.forEach((document) {
//         batch.update(document.reference, {'readAt': now});
//       });

//       await batch.commit();
//       await conversationUpdated();
//       messages!.forEach((element) {
//         element.readAt ??= now.toDate();
//       });
//     }
//   }

//   Future<void> conversationUpdated() async {
//     await FirebaseFirestore.instance
//         .collection('conversations')
//         .doc(conversationId)
//         .update({'updatedAt': Timestamp.now()});
//   }
// }
