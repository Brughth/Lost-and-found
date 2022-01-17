import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lost_and_found/src/authentification/user_model.dart';
import 'package:lost_and_found/src/services/user_services.dart';
import 'package:meta/meta.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserService userServices = UserService();
  final String uid = FirebaseAuth.instance.currentUser!.uid;

  UserCubit() : super(UserInitial());

  getAuthenticatedUser() async {
    try {
      var data = await userServices.getUser(uid).then((value) => value.data());
      UserModel user = UserModel(
          uid: uid,
          name: data!['name'],
          email: data['email'],
          tel: data['tel'],
          photoUrl: data['photo_url'],
          teken: data['token'],
          subname: data['subname']);
      emit(UserState(user: user));
      return user;
    } catch (e) {
      print(e);
    }
  }
}
