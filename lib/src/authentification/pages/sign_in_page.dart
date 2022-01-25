import 'dart:developer';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lost_and_found/home_page.dart';
import 'package:lost_and_found/src/authentification/cubit/user_cubit.dart';
import 'package:lost_and_found/src/authentification/pages/sign_up_page.dart';
import 'package:lost_and_found/src/utils/app_colors.dart';
import 'package:lost_and_found/src/utils/app_exception.dart';
import 'package:lost_and_found/src/utils/app_input.dart';
import 'package:lost_and_found/src/utils/app_button.dart';

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
    double screemWidth = MediaQuery.of(context).size.width;
    double screemHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.primary,
          title: const Text(
            "Login",
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
                MaterialPageRoute(builder: (context) => const HomePage()),
                (route) => false,
              );
            }
          },
          builder: (contex, state) {
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
                                'Lost And Found',
                                duration: const Duration(milliseconds: 7000),
                                fadeOutBegin: 1,
                              ),
                              FadeAnimatedText(
                                'Log in to find a lost item.',
                                duration: const Duration(milliseconds: 7000),
                              ),
                              FadeAnimatedText(
                                'Log in to find the owner of \na picked up item.',
                                duration: const Duration(milliseconds: 7000),
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
                      children: [
                        AppInput(
                          controller: _emailController,
                          label: "Email",
                        ),
                        AppInput(
                          controller: _passwordController,
                          maxLines: 1,
                          label: "Password",
                          obscureText: true,
                        ),
                        if (isLoading)
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
                        SizedBox(
                          height: screemHeight * .02,
                        ),
                        AppButton(
                          text: "Login",
                          onTap: () async {
                            if (_emailController.text.isEmpty ||
                                _passwordController.text.isEmpty) {
                              Fluttertoast.showToast(
                                  msg: "all fields are required");
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
                      text: "Don't have an account ? ",
                      style: const TextStyle(
                        color: AppColors.primaryText,
                        fontSize: 17,
                      ),
                      children: [
                        TextSpan(
                          text: "Register",
                          style: const TextStyle(
                            color: AppColors.secondary,
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => const SignUpPage(),
                                ),
                              );
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
