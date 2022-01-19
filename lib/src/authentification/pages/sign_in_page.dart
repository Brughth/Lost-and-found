import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lost_and_found/home_page.dart';
import 'package:lost_and_found/src/authentification/cubit/user_cubit.dart';
import 'package:lost_and_found/src/widget/app_button.dart';
import 'package:lost_and_found/src/widget/app_imput.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  late TextEditingController _passwordController;
  late TextEditingController _emailController;
  String? error;
  bool isLoading = false;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 0.5,
          backgroundColor: const Color(0xFF212121),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xFF909093)),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: BlocConsumer<UserCubit, UserState>(
          listener: (context, state) {
            if (state.successLogingIn) {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const HomePage()),
                (route) => false,
              );
            }
          },
          builder: (contex, state) {
            return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                color: Color(0xFF212121),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    height: 100,
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
                                'Lost And Found',
                                duration: const Duration(milliseconds: 5000),
                                fadeOutBegin: 1,
                              ),
                              FadeAnimatedText(
                                'Inscrire toi pour trouver \nun l\'objet perdu.',
                                duration: const Duration(milliseconds: 10000),
                              ),
                              FadeAnimatedText(
                                'Inscrire toi pour trouver\nle propriétaire d\'un\nl’objet ramassé.',
                                duration: const Duration(milliseconds: 10000),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: 330,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        AppImput(
                          controller: _emailController,
                          hintText: "Email",
                          obscureText: false,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        AppImput(
                          controller: _passwordController,
                          hintText: "Mot De Passe",
                          obscureText: true,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        if (isLoading)
                          const Center(
                            child: CircularProgressIndicator(),
                          ),
                        if (error != null)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              error!,
                              style: const TextStyle(
                                color: Colors.red,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  AppButton(
                    text: "Se Connecter",
                    firstColor: const Color(0xFFff7521),
                    secondColor: const Color(0xFFffb421),
                    onTap: () async {
                      if (_emailController.text.isEmpty ||
                          _passwordController.text.isEmpty) {
                        Fluttertoast.showToast(
                            msg: "tous les chanps sont requies");
                      } else {
                        try {
                          setState(() {
                            isLoading = true;
                            error = null;
                          });

                          await contex.read<UserCubit>().attemptLogin(
                                email: _emailController.text.trim(),
                                password: _passwordController.text.trim(),
                              );

                          setState(() {
                            isLoading = false;
                          });

                          // var user =
                          //     await _authServices.loginWithEmailAndPassword(
                          //   email: _emailController.text,
                          //   password: _passwordController.text,
                          // );

                          // setState(() {
                          //   isLoading = false;
                          // });

                          // Navigator.of(context).pushAndRemoveUntil(
                          //     MaterialPageRoute(
                          //         builder: (context) => const HomePage()),
                          //     (route) => false);
                          // } on FirebaseAuthException catch (e) {
                          //   if (e.code == 'weak-password') {
                          //     print('The password provided is too weak.');
                          //   } else if (e.code == 'email-already-in-use') {
                          //     print('The account already exists for that email.');
                          //   }

                          //   setState(() {
                          //     isLoading = false;
                          //     error = e.message;
                          //   });
                        } catch (e) {
                          print(e);
                          setState(() {
                            isLoading = false;
                          });
                        }
                      }
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            );
          },
        ));
  }
}
