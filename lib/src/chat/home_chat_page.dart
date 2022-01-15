import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lost_and_found/src/chat/chat_page.dart';
import 'package:lost_and_found/src/chat/chat_parans.dart';
import 'package:lost_and_found/src/utils/app_colors.dart';

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
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
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

                      return GestureDetector(
                        onTap: () {
                          ChatParams chatParams = ChatParams(
                            userId: currentUser.uid,
                            peerId: uid['freindId'],
                            peerName: user['name'],
                          );
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  ChatPage(chatParams: chatParams),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            children: [
                              user['photo_url'] != null
                                  ? CircleAvatar(
                                      backgroundColor: AppColors.primary,
                                      radius: 26,
                                      child: CircleAvatar(
                                        backgroundImage: user['photo'] != null
                                            ? NetworkImage(user['photo_urt'])
                                            : null,
                                        radius: 25,
                                      ),
                                    )
                                  : const CircleAvatar(
                                      backgroundColor: AppColors.primary,
                                      radius: 26,
                                      child: CircleAvatar(
                                        radius: 25,
                                        backgroundColor: AppColors.secondary,
                                      ),
                                    ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          text: "${user['name']} ",
                                          style: const TextStyle(
                                            color: AppColors.primaryText,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 17,
                                          ),
                                          children: [
                                            if (user['subname'] != null)
                                              TextSpan(
                                                text: user['subname'],
                                                style: const TextStyle(
                                                  color: AppColors.primaryText,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 17,
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 0.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              user['tel'],
                                              style: const TextStyle(
                                                color: AppColors.primaryText,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(right: 8.0),
                                              child: Text(
                                                DateFormat.yMMMd().format(
                                                    DateTime.parse(
                                                        "${uid['updateAt']}")),
                                                style: const TextStyle(
                                                  color: AppColors.primaryText,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                      // return Padding(
                      //   padding: const EdgeInsets.symmetric(
                      //       horizontal: 10, vertical: 10),
                      //   child: Container(
                      //     width: double.infinity,
                      //     child: Row(
                      //       children: [
                      //         CircleAvatar(
                      //           radius: 30,
                      //           backgroundColor: AppColors.primary,
                      //           child: CircleAvatar(
                      //             radius: 28,
                      //             backgroundColor: AppColors.secondary,
                      //           ),
                      //         ),

                      //       ],
                      //     ),
                      //   ),
                      // );
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
