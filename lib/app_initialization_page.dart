import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lost_and_found/home_page.dart';
import 'package:lost_and_found/src/authentification/pages/sign_in_page.dart';
import 'package:lost_and_found/src/utils/app_routes.dart';

class AppInitializationPage extends StatefulWidget {
  const AppInitializationPage({Key? key}) : super(key: key);

  @override
  _AppInitializationPageState createState() => _AppInitializationPageState();
}

class _AppInitializationPageState extends State<AppInitializationPage> {
  @override
  void initState() {
    super.initState();
    checkAuthState();
  }

  checkAuthState() {
    if (FirebaseAuth.instance.currentUser != null) {
      setRoot(context, const HomePage());
    } else {
      setRoot(context, const SignInPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
