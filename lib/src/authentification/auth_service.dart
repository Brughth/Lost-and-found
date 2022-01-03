import 'package:firebase_auth/firebase_auth.dart';
import 'package:lost_and_found/src/services/user_services.dart';

class AuthServices {
  //instantiation le la class
  late UserService _userService;

  AuthServices() {
    _userService = UserService();
  }

  FirebaseAuth auth = FirebaseAuth.instance;
  Stream<User?> get userStream {
    return FirebaseAuth.instance.authStateChanges();
  }

  User? get user {
    return FirebaseAuth.instance.currentUser;
  }

  Future<UserCredential> registedWithEmailAndPassword({
    required String name,
    required String email,
    required String tel,
    required String password,
  }) async {
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password.trim(),
    );

    _userService.updateAccount(userCredential.user!.uid,
        {"name": name.trim(), "email": email.trim(), "tel": tel.trim()});

    return userCredential;
  }

  loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    UserCredential userCredential = await auth.signInWithEmailAndPassword(
      email: email.trim(),
      password: password.trim(),
    );

    return userCredential;
  }

  logout() async {
    await auth.signOut();
  }
}
