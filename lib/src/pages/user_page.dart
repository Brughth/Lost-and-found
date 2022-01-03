import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lost_and_found/src/authentification/auth_service.dart';
import 'package:lost_and_found/src/pages/edite_user_page.dart';
import 'package:lost_and_found/welcome.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage>
    with AutomaticKeepAliveClientMixin {
  late User user;
  late DocumentReference userRef;
  late Stream<DocumentSnapshot> userStream;
  String sex = "M";
  late Map<String, dynamic>? data;
  late AuthServices _authServices;

  @override
  void initState() {
    user = FirebaseAuth.instance.currentUser!;
    userRef = FirebaseFirestore.instance.collection("users").doc(user.uid);
    userStream = userRef.snapshots();
    _authServices = AuthServices();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: const Color(0xFF212121),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF909093)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              _authServices.logout();
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const Welcome()),
                  (route) => false);
            },
            icon: const Icon(
              Icons.logout,
              color: Color(0xFF909093),
            ),
          )
        ],
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: userStream,
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
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
            //data = snapshot.data!.data() as Map<String, dynamic>;
            data = snapshot.data!.data() as Map<String, dynamic>?;
            return ListView(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: const BoxDecoration(
                    color: Color(0xFF212121),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      CircleAvatar(
                        radius: 100,
                        backgroundColor: const Color(0xFFff7521),
                        child: CircleAvatar(
                          radius: 98,
                          backgroundImage:
                              NetworkImage("${data!['photo_url'] ?? ''}"),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 40),
                        child: Column(
                          children: [
                            ListTile(
                              trailing: Icon(
                                Icons.email,
                                color: const Color(0xFFff7521).withOpacity(.7),
                              ),
                              tileColor: Colors.white,
                              title: const Text(
                                "Email",
                                style: TextStyle(
                                  color: Color(0xFFff7521),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text(
                                  "${data!['email'] ?? ''}",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ),
                            const Divider(
                              color: Color(0xFFffffff),
                              height: 8,
                            ),
                            ListTile(
                              tileColor: Colors.white,
                              trailing: Icon(
                                Icons.person,
                                color: const Color(0xFFff7521).withOpacity(.7),
                              ),
                              title: const Text(
                                "Nom",
                                style: TextStyle(
                                  color: Color(0xFFff7521),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text(
                                  "${data!['name'] ?? ''}",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ),
                            const Divider(
                              color: Color(0xFFffffff),
                              height: 8,
                            ),
                            ListTile(
                              tileColor: Colors.white,
                              trailing: Icon(
                                Icons.person,
                                color: const Color(0xFFff7521).withOpacity(.7),
                              ),
                              title: const Text(
                                "Prenom",
                                style: TextStyle(
                                  color: Color(0xFFff7521),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text(
                                  "${data!['subname'] ?? ''}",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ),
                            const Divider(
                              color: Color(0xFFffffff),
                              height: 8,
                            ),
                            ListTile(
                              tileColor: Colors.white,
                              trailing: Icon(
                                Icons.phone,
                                color: const Color(0xFFff7521).withOpacity(.7),
                              ),
                              title: const Text(
                                "Phone",
                                style: TextStyle(
                                  color: Color(0xFFff7521),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text(
                                  "${data!['tel'] ?? ''}",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFff7521).withOpacity(.8),
        child: const Icon(Icons.edit),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditeUserPage(
                data: data!,
                id: user.uid,
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
