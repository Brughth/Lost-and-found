import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lost_and_found/src/authentification/auth_service.dart';
import 'package:lost_and_found/src/authentification/pages/sign_in_page.dart';
import 'package:lost_and_found/src/pages/edite_user_page.dart';
import 'package:lost_and_found/src/utils/app_colors.dart';

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
    double screenHiegrh = MediaQuery.of(context).size.height;
    double screenWidgth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          "Profile",
          style: TextStyle(
            color: AppColors.primaryGrayText,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              _authServices.logout();
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const SignInPage()),
                  (route) => false);
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
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
            data = snapshot.data!.data() as Map<String, dynamic>?;
            return Stack(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: screenHiegrh * .025,
                      ),
                      CircleAvatar(
                        radius: 100,
                        backgroundColor: AppColors.primary,
                        child: CircleAvatar(
                          radius: 98,
                          backgroundImage: data!['photo_url'] == null
                              ? null
                              : NetworkImage(data!['photo_url']),
                        ),
                      ),
                      SizedBox(
                        height: screenHiegrh * .01,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: screenWidgth * .01),
                        child: Column(
                          children: [
                            ListTile(
                              trailing: const Icon(
                                Icons.email,
                                color: AppColors.primary,
                              ),
                              tileColor: Colors.white,
                              title: const Text(
                                "Email",
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text(
                                  "${data!['email'] ?? ''}",
                                  style: const TextStyle(
                                    color: AppColors.primaryText,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                            ),
                            Divider(
                              color: AppColors.primary,
                              height: screenHiegrh * .008,
                            ),
                            ListTile(
                              trailing: const Icon(
                                Icons.person,
                                color: AppColors.primary,
                              ),
                              title: const Text(
                                "Name",
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text(
                                  "${data!['name'] ?? ''}",
                                  style: const TextStyle(
                                    color: AppColors.primaryText,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                            ),
                            Divider(
                              color: AppColors.primary,
                              height: screenHiegrh * .008,
                            ),
                            ListTile(
                              tileColor: Colors.white,
                              trailing: const Icon(
                                Icons.person,
                                color: AppColors.primary,
                              ),
                              title: const Text(
                                "Prenom",
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text(
                                  "${data!['subname'] ?? ''}",
                                  style: const TextStyle(
                                    color: AppColors.primaryText,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                            ),
                            Divider(
                              color: AppColors.primary,
                              height: screenHiegrh * .008,
                            ),
                            ListTile(
                              tileColor: Colors.white,
                              trailing: const Icon(
                                Icons.phone,
                                color: AppColors.primary,
                              ),
                              title: const Text(
                                "Phone",
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text(
                                  "${data!['tel'] ?? ''}",
                                  style: const TextStyle(
                                    color: AppColors.primaryText,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 17,
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
        heroTag: "btn 3",
        backgroundColor: AppColors.primary,
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
