import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lost_and_found/home_page.dart';
import 'package:lost_and_found/src/authentification/auth_service.dart';
import 'package:lost_and_found/src/authentification/cubit/user_cubit.dart';
import 'package:lost_and_found/src/utils/app_button.dart';
import 'package:lost_and_found/src/utils/app_colors.dart';
import 'package:lost_and_found/src/utils/app_input.dart';
import 'package:lost_and_found/src/widget/app_imput.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _telController;
  late TextEditingController _passwordController;
  late AuthServices _authServices;
  String? error;
  bool isLoading = false;

  @override
  void initState() {
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _telController = TextEditingController();
    _passwordController = TextEditingController();
    _authServices = AuthServices();
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
        body: SingleChildScrollView(
          child: BlocConsumer<UserCubit, UserState>(
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
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: 330,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          AppInput(
                            controller: _nameController,
                            label: "Name",
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          AppImput(
                            controller: _emailController,
                            hintText: "Email",
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          AppImput(
                            controller: _telController,
                            hintText: "Telephone",
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
                            )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 40,
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
                              error = null;
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
              );
            },
          ),
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



// SingleChildScrollView(
//         child: Container(
//           width: MediaQuery.of(context).size.width,
//           height: MediaQuery.of(context).size.height,
//           decoration: const BoxDecoration(
//             color: Color(0xFF212121),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               const SizedBox(
//                 height: 30,
//               ),
//               SizedBox(
//                 height: 100,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     DefaultTextStyle(
//                       style: const TextStyle(
//                         fontSize: 25,
//                         fontWeight: FontWeight.bold,
//                         color: Color(0xFF909093),
//                       ),
//                       child: AnimatedTextKit(
//                         repeatForever: true,
//                         isRepeatingAnimation: true,
//                         animatedTexts: [
//                           FadeAnimatedText(
//                             'Soyons Humble',
//                             duration: const Duration(milliseconds: 5000),
//                             fadeOutBegin: 1,
//                           ),
//                           FadeAnimatedText(
//                             'Inscrire toi pour trouver \nun objet perdu.',
//                             duration: const Duration(milliseconds: 10000),
//                           ),
//                           FadeAnimatedText(
//                             'Inscrire toi pour trouver\nle propriétaire d\'un\nobjet ramassé.',
//                             duration: const Duration(milliseconds: 10000),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(
//                 height: 30,
//               ),
//               SizedBox(
//                 width: 330,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: [
//                     AppInput(
//                       controller: _nameController,
//                       label: "Name",
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     AppImput(
//                       controller: _emailController,
//                       hintText: "Email",
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     AppImput(
//                       controller: _telController,
//                       hintText: "Telephone",
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     AppImput(
//                       controller: _passwordController,
//                       hintText: "Mot De Passe",
//                       obscureText: true,
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     if (isLoading)
//                       const Center(
//                         child: CircularProgressIndicator(),
//                       ),
//                     if (error != null)
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Text(
//                           error!,
//                           style: const TextStyle(
//                             color: Colors.red,
//                           ),
//                         ),
//                       )
//                   ],
//                 ),
//               ),
//               const SizedBox(
//                 height: 40,
//               ),
//               AppButton(
//                 text: "S'inscrire",
//                 onTap: () async {
//                   try {
//                     setState(() {
//                       isLoading = true;
//                       error = null;
//                     });

//                     var user = await _authServices.registedWithEmailAndPassword(
//                       name: _nameController.text,
//                       email: _emailController.text,
//                       tel: _telController.text,
//                       password: _passwordController.text,
//                     );

//                     setState(() {
//                       isLoading = false;
//                     });

//                     Navigator.of(context).pushAndRemoveUntil(
//                         MaterialPageRoute(
//                             builder: (context) => const HomePage()),
//                         (route) => false);
//                   } on FirebaseAuthException catch (e) {
//                     if (e.code == 'weak-password') {
//                       print('The password provided is too weak.');
//                     } else if (e.code == 'email-already-in-use') {
//                       print('The account already exists for that email.');
//                     }

//                     setState(() {
//                       isLoading = false;
//                       error = e.message;
//                     });
//                   } catch (e) {
//                     print(e);
//                     setState(() {
//                       isLoading = false;
//                       e.toString();
//                     });
//                   }
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
    