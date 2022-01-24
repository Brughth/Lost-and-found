import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lost_and_found/home_page.dart';
import 'package:lost_and_found/src/authentification/cubit/user_cubit.dart';
import 'package:lost_and_found/src/authentification/pages/sign_in_page.dart';
import 'package:lost_and_found/src/utils/app_button.dart';
import 'package:lost_and_found/src/utils/app_colors.dart';
import 'package:lost_and_found/src/utils/app_exception.dart';
import 'package:lost_and_found/src/utils/app_input.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  //final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _telController;
  late TextEditingController _passwordController;
  String? error;
  bool isLoading = false;

  @override
  void initState() {
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _telController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _telController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screemWidth = MediaQuery.of(context).size.width;
    double screemHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.primary,
          title: const Text(
            "Register",
            style: TextStyle(
              fontSize: 22,
            ),
          ),
          centerTitle: true,
        ),
        body: BlocConsumer<UserCubit, UserState>(
          listener: (context, state) {
            if (state.successLogingIn) {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ),
                (route) => false,
              );
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: screemHeight * .2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        DefaultTextStyle(
                          style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF909093),
                          ),
                          child: AnimatedTextKit(
                            repeatForever: true,
                            isRepeatingAnimation: true,
                            animatedTexts: [
                              FadeAnimatedText(
                                'Soyons Humble',
                                duration: const Duration(milliseconds: 5000),
                                fadeOutBegin: 1,
                              ),
                              FadeAnimatedText(
                                'Inscrire toi pour trouver \nun objet perdu.',
                                duration: const Duration(milliseconds: 10000),
                              ),
                              FadeAnimatedText(
                                'Inscrire toi pour trouver\nle propriétaire d\'un\nobjet ramassé.',
                                duration: const Duration(milliseconds: 10000),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: screemWidth * 0.05),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        AppInput(
                          controller: _nameController,
                          label: "Name",
                        ),
                        AppInput(
                          controller: _emailController,
                          label: "Email",
                        ),
                        AppInput(
                          controller: _telController,
                          label: "Telephone",
                        ),
                        AppInput(
                          controller: _passwordController,
                          label: "Mot De Passe",
                          maxLines: 1,
                          obscureText: true,
                        ),
                        if (state.copyWith().isLogingIn)
                          const Center(
                            child: CircularProgressIndicator(),
                          ),
                        if (state.copyWith().error != null)
                          Text(
                            appAuthException(
                                codeerror: "${state.copyWith().error}"),
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        AppButton(
                          text: "S'inscrire",
                          onTap: () async {
                            if (_nameController.text.isEmpty ||
                                _passwordController.text.isEmpty ||
                                _emailController.text.isEmpty ||
                                _telController.text.isEmpty) {
                              Fluttertoast.showToast(
                                msg: "tous les champs sont requis",
                                backgroundColor: AppColors.primary,
                                textColor: Colors.white,
                              );
                            } else {
                              try {
                                setState(() {
                                  isLoading = true;
                                });

                                context.read<UserCubit>().register(
                                      email: _emailController.text.trim(),
                                      name: _nameController.text.trim(),
                                      tel: _telController.text.trim(),
                                      password: _passwordController.text.trim(),
                                    );
                                setState(() {
                                  isLoading = false;
                                });
                              } catch (e) {
                                print(e);
                                setState(() {
                                  isLoading = false;
                                });
                              }
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: screemHeight * .01,
                  ),
                  RichText(
                    textAlign: TextAlign.end,
                    text: TextSpan(
                      text: "Already have an account ? ",
                      style: const TextStyle(
                        color: AppColors.primaryText,
                        fontSize: 17,
                      ),
                      children: [
                        TextSpan(
                          text: "Login",
                          style: const TextStyle(
                            color: AppColors.secondary,
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => const SignInPage()),
                                  (route) => false);
                            },
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ));
  }
}


// Future<void> register() async {
//     setState(() => isLoading = true);
//     try {
//       UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
//         email: emailController.text,
//         password: passwordController.text,
//       );
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'weak-password') {
//         passwordErrorMessage = 'The password provided is too weak.';
//       } else if (e.code == 'email-already-in-use') {
//         emailErrorMessage = 'The account already exists for that email.';
//       }
//     } catch (e) {
//       print(e);
//     }
//     setState(() => isLoading = false);
//   }