import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lost_and_found/src/pages/add_found_objet_page.dart';
import 'package:lost_and_found/src/utils/app_colors.dart';
import 'package:lost_and_found/src/widget/objet_widget.dart';

class FoundObjetPage extends StatefulWidget {
  const FoundObjetPage({Key? key}) : super(key: key);

  @override
  _FoundObjetPageState createState() => _FoundObjetPageState();
}

class _FoundObjetPageState extends State<FoundObjetPage>
    with AutomaticKeepAliveClientMixin {
  late Stream<QuerySnapshot> objetStream;
  late List<QueryDocumentSnapshot> data;

  @override
  void initState() {
    objetStream = FirebaseFirestore.instance
        .collection("found_objet")
        .orderBy("createdAt", descending: true)
        .snapshots();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeigth = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder<QuerySnapshot>(
        stream: objetStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(
                "${snapshot.error}",
                style: const TextStyle(
                  color: Colors.red,
                ),
              ),
            );
          }
          if (snapshot.hasData) {
            data = snapshot.data!.docs;

            if (snapshot.data!.size == 0) {
              return const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: Text("No lost objet yet"),
                ),
              );
            } else {
              return ListView.separated(
                itemCount: snapshot.data!.size,
                separatorBuilder: (context, index) {
                  return Container(
                    height: screenHeigth * 0.01,
                    decoration: const BoxDecoration(color: AppColors.grayScale),
                  );
                },
                itemBuilder: (context, index) {
                  var objet = data[index];
                  var userStream = FirebaseFirestore.instance
                      .collection("users")
                      .doc("${objet['user_id']}")
                      .snapshots();
                  return StreamBuilder<DocumentSnapshot>(
                      stream: userStream,
                      builder: (BuildContext context,
                          AsyncSnapshot<DocumentSnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        if (snapshot.hasError) {
                          return Center(
                            child: Text(
                              "${snapshot.error}",
                              style: const TextStyle(
                                color: Colors.red,
                              ),
                            ),
                          );
                        }

                        var user =
                            snapshot.data!.data() as Map<String, dynamic>;
                        return ObjetWidget(
                          title: "${objet['title']}",
                          description: "${objet['description']}",
                          image: "${objet['image']}",
                          createAd: "${objet['createdAt']}",
                          userImage: "${user['photo_url']}",
                          usersubname: "${user['subname']}",
                          userId: "${objet['user_id']}",
                          username: "${user['name']}",
                          isLost: false,
                        );
                      });
                },
              );
            }
          }
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "btn 2",
        backgroundColor: AppColors.primary,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddFoundObjetPage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
