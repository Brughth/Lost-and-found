import 'package:bloc/bloc.dart';
import 'package:lost_and_found/src/authentification/auth_service.dart';
import 'package:lost_and_found/src/authentification/user_model.dart';
import 'package:lost_and_found/src/services/user_services.dart';
import 'package:meta/meta.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserService userServices = UserService();
  final AuthServices authServices = AuthServices();

  UserCubit() : super(UserInitial());

  Future attemptLogin({required String email, required String password}) async {
    try {
      emit(
        state.copyWith(
          isLogingIn: true,
          errorLogingIn: false,
          successLogingIn: false,
        ),
      );

      var user = await authServices.loginWithEmailAndPassword(
        email: email,
        password: password,
      );

      var data = await userServices
          .getUser(user.user!.uid)
          .then((value) => value.data());

      UserModel userModel = UserModel(
        name: data!['name'],
        uid: user.user!.uid,
        email: data['email'],
        tel: data['tel'],
        photoUrl: data['photo_url'],
        token: data['token'],
        subname: data['subname'],
      );

      emit(
        state.copyWith(
          user: userModel,
          isLogingIn: false,
          errorLogingIn: false,
          successLogingIn: true,
        ),
      );
    } catch (e) {
      print(e);
      emit(
        state.copyWith(
            isLogingIn: false, errorLogingIn: true, successLogingIn: false),
      );
    }
  }

  getAuthenticatedUser(String userId) async {
    try {
      var data =
          await userServices.getUser(userId).then((value) => value.data());
      UserModel user = UserModel(
          name: data!['name'],
          uid: userId,
          email: data['email'],
          tel: data['tel'],
          photoUrl: data['photo_url'],
          token: data['token'],
          subname: data['subname']);
      emit(
        state.copyWith(user: user),
      );
    } catch (e) {
      print(e);
    }
  }
}
