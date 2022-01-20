import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lost_and_found/src/chat/chat_page.dart';
import 'package:lost_and_found/src/chat/chat_parans.dart';
import 'package:lost_and_found/src/utils/app_colors.dart';
import 'package:lost_and_found/src/widget/conversation_item.dart';

class HomeChtaPage extends StatefulWidget {
  const HomeChtaPage({Key? key}) : super(key: key);

  @override
  _HomeChtaPageState createState() => _HomeChtaPageState();
}

class _HomeChtaPageState extends State<HomeChtaPage> {
  late User currentUser;
  @override
  void initState() {
    currentUser = FirebaseAuth.instance.currentUser!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text(
          "Chat",
          style: TextStyle(
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("conversations")
            .doc(currentUser.uid)
            .collection(currentUser.uid)
            .orderBy('updateAt', descending: true)
            .snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshop) {
          if (!snapshop.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshop.hasError) {
            return Center(
              child: Text(
                snapshop.error.toString(),
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          if (snapshop.hasData) {
            var data = snapshop.data!.docs;
            return ListView.builder(
              itemCount: snapshop.data!.size,
              itemBuilder: (context, index) {
                var uid = data[index];

                return StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("users")
                      .doc(uid['freindId'])
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                          snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      print(snapshot.error);
                      return Center(
                        child: Text("${snapshop.error}"),
                      );
                    }

                    if (snapshot.hasData) {
                      var user = snapshot.data!.data() as Map<String, dynamic>;

                      return ConversationItem(
                        userId: currentUser.uid,
                        peedId: uid['freindId'],
                        userName: user['name'],
                        userPhoto: user['photo_url'],
                        userSubName: user['subname'],
                        userTel: user['tel'],
                        updateAt: uid['updateAt'],
                      );
                    }
                    return Container();
                  },
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
