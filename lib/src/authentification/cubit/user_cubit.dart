import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
          error: null,
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
            error: null),
      );

      getAuthenticatedUser(user.user!.uid);
    } on FirebaseAuthException catch (error) {
      print(error.code);
      emit(
        state.copyWith(
          error: error.code,
          isLogingIn: false,
          errorLogingIn: true,
          successLogingIn: false,
        ),
      );
    } catch (e) {
      print(e);
      emit(
        state.copyWith(
          error: e.toString(),
          isLogingIn: false,
          errorLogingIn: true,
          successLogingIn: false,
        ),
      );
    }
  }

  register({
    required String name,
    required String email,
    required String password,
    required String tel,
  }) async {
    try {
      emit(
        state.copyWith(
          error: null,
          isLogingIn: true,
          errorLogingIn: false,
          successLogingIn: false,
        ),
      );

      var u = await authServices.registedWithEmailAndPassword(
        name: name,
        email: email,
        tel: tel,
        password: password,
      );

      await attemptLogin(
        email: email,
        password: password,
      );

      getAuthenticatedUser(u.user!.uid);
    } on FirebaseAuthException catch (error) {
      print(error.code);
      emit(state.copyWith(
        error: error.code,
        isLogingIn: false,
        errorLogingIn: true,
        successLogingIn: false,
      ));
    } catch (e) {
      print(e);
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



// try {
//     AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
//     user = result.user;
//   } catch (error) {
    // switch (error.code) {
    //   case "ERROR_INVALID_EMAIL":
    //     errorMessage = "Your email address appears to be malformed.";
    //     break;
    //   case "ERROR_WRONG_PASSWORD":
    //     errorMessage = "Your password is wrong.";
    //     break;
    //   case "ERROR_USER_NOT_FOUND":
    //     errorMessage = "User with this email doesn't exist.";
    //     break;
    //   case "ERROR_USER_DISABLED":
    //     errorMessage = "User with this email has been disabled.";
    //     break;
    //   case "ERROR_TOO_MANY_REQUESTS":
    //     errorMessage = "Too many requests. Try again later.";
    //     break;
    //   case "ERROR_OPERATION_NOT_ALLOWED":
    //     errorMessage = "Signing in with Email and Password is not enabled.";
    //     break;
    //   default:
    //     errorMessage = "An undefined Error happened.";
//     }
//   }

//   if (errorMessage != null) {
//     return Future.error(errorMessage);
//   }

//   return user.uid;
// }

