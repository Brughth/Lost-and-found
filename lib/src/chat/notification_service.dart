import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  static void initialize() {
    // for ios
    FirebaseMessaging.instance.requestPermission();

    FirebaseMessaging.onMessage.listen((event) {
      print("A new onMessage envent was published");
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("A new onMessageOpenApp event was published");
    });
  }

  Future<String?> getToken() async {
    return FirebaseMessaging.instance.getToken();
  }
}
