import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lost_and_found/src/pages/add_lost_objet_page.dart';
import 'package:lost_and_found/src/widget/objet_widget.dart';

class LostObjePage extends StatefulWidget {
  const LostObjePage({Key? key}) : super(key: key);

  @override
  _LostObjePageState createState() => _LostObjePageState();
}

class _LostObjePageState extends State<LostObjePage> {
  late Stream<QuerySnapshot> objetStream;
  late List<QueryDocumentSnapshot> data;

  @override
  void initState() {
    objetStream =
        FirebaseFirestore.instance.collection("lost_objet").snapshots();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // double screenHeigth = MediaQuery.of(context).size.height;
    // double screenwidth = MediaQuery.of(context).size.width;

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

            if (snapshot.data!.size == -0) {
              return const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: Text("No lost objet yet"),
                ),
              );
            } else {
              return ListView(
                children: data.map((ob) {
                  Stream<DocumentSnapshot<Map<String, dynamic>>> userStream =
                      FirebaseFirestore.instance
                          .collection("users")
                          .doc(ob['user_id'])
                          .snapshots();
                  return StreamBuilder(
                    stream: userStream,
                    builder: (BuildContext context,
                        AsyncSnapshot<DocumentSnapshot> snapshot) {
                      var user = snapshot.data!.data() as Map<String, dynamic>;
                      return ObjetWidget(
                        title: "${ob['title']}",
                        description: "${ob['description']}",
                        image: "${ob['image']}",
                        userImage: "${user['photo_url']}",
                        username: "${user['name']}",
                        usersubname: "${user['subname']}",
                      );
                    },
                  );
                }).toList(),
              );
            }
          }
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddLostObjetPage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}


// StreamBuilder<DocumentSnapshot>(
//                     stream: FirebaseFirestore.instance
//                         .collection("users")
//                         .doc(objet['user_id'])
//                         .snapshots(),
//                     builder: (BuildContext context,
//                         AsyncSnapshot<DocumentSnapshot> snapshot) {
//                       var user = snapshot.data!.data() as Map<String, dynamic>;
//                       print("bbolice $user");
//                       return ObjetWidget(
//                         title: "${objet['title']}",
//                         description: "${objet['description']}",
//                         image: "${objet['image']}",
//                         userImage: "${user['photo_url']}",
//                         username: "${user['name']}",
//                         usersubname: "${user['subname']}",
//                       );
//                     },
//                   );


// ListView.builder(
//                 physics: AlwaysScrollableScrollPhysics(),
//                 itemCount: snapshot.data!.size,
//                 itemBuilder: (context, index) {
//                   var objet =
//                       snapshot.data!.docs[index].data() as Map<String, dynamic>;
//                   Stream<DocumentSnapshot> userStream = FirebaseFirestore
//                       .instance
//                       .collection("users")
//                       .doc(objet['user_id'])
//                       .snapshots();
//                   return ObjetWidget(
//                     title: "${objet['title']}",
//                     description: "${objet['description']}",
//                     image: "${objet['image']}",
//                     // userImage: "${user['photo_url']}",
//                     // username: "${user['name']}",
//                     // usersubname: "${user['subname']}",
//                     userImage:
//                         "https://www.google.com/imgres?imgurl=https%3A%2F%2Fimg-19.ccm2.net%2FcI8qqj-finfDcmx6jMK6Vr-krEw%3D%2F1500x%2Fsmart%2Fb829396acc244fd484c5ddcdcb2b08f3%2Fccmcms-commentcamarche%2F20494859.jpg&imgrefurl=https%3A%2F%2Fwww.commentcamarche.net%2Fapplis-sites%2Fservices-en-ligne%2F729-faire-une-recherche-a-partir-d-une-image-sur-google%2F&tbnid=oRy0z0IP_DCq7M&vet=12ahUKEwj02I-joZT1AhVI5IUKHYd6BFkQMygBegUIARDNAQ..i&docid=wu2NBJuBKFH9OM&w=1500&h=1000&itg=1&q=image&ved=2ahUKEwj02I-joZT1AhVI5IUKHYd6BFkQMygBegUIARDNAQ",
//                     username: "sona",
//                     usersubname: "olice",
//                   );
//                 },
//               );