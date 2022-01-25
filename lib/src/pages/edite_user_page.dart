import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lost_and_found/src/authentification/cubit/user_cubit.dart';
import 'package:lost_and_found/src/services/user_services.dart';
import 'package:lost_and_found/src/utils/app_button.dart';
import 'package:lost_and_found/src/utils/app_colors.dart';
import 'package:lost_and_found/src/utils/app_input.dart';

class EditeUserPage extends StatefulWidget {
  final Map<String, dynamic> data;
  final String id;
  const EditeUserPage({
    Key? key,
    required this.id,
    required this.data,
  }) : super(key: key);

  @override
  _EditeUserPageState createState() => _EditeUserPageState();
}

class _EditeUserPageState extends State<EditeUserPage> {
  late TextEditingController _nameController;
  late TextEditingController _subnameController;
  late TextEditingController _emailController;
  late TextEditingController _telController;
  XFile? currentImage;

  bool isLoading = false;
  String? error;

  FirebaseFirestore storage = FirebaseFirestore.instance;

  @override
  void initState() {
    _nameController = TextEditingController(text: widget.data['name'] ?? '');
    _subnameController =
        TextEditingController(text: widget.data['subname'] ?? '');
    _emailController = TextEditingController(text: widget.data['email'] ?? '');
    _telController = TextEditingController(text: widget.data['tel'] ?? '');
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _telController.dispose();
    _subnameController.dispose();
    super.dispose();
  }

  Future<Map<String, dynamic>> getData() async {
    Map<String, dynamic> data = {};
    if (currentImage != null) {
      File file = File(currentImage!.path);

      try {
        var ref = FirebaseStorage.instance.ref(widget.id);
        var uploadedFile = await ref.putFile(file);

        data['photo_url'] = await uploadedFile.ref.getDownloadURL();
      } on FirebaseException catch (e) {
        print(e);
      }
    }

    data['email'] = _emailController.text;
    data['name'] = _nameController.text;
    data['subname'] = _subnameController.text;
    data['tel'] = _telController.text;

    return data;
  }

  @override
  Widget build(BuildContext context) {
    double screenHiegrh = MediaQuery.of(context).size.height;
    double screenWidgth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          "Edit Profile",
          style: TextStyle(
            color: AppColors.primaryGrayText,
            fontWeight: FontWeight.bold,
            fontSize: 23,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Column(
            children: [
              SizedBox(
                height: screenHiegrh * .025,
              ),
              Stack(
                children: [
                  SizedBox(
                    width: screenWidgth,
                    child: CircleAvatar(
                      radius: 100,
                      backgroundColor: AppColors.primary,
                      child: currentImage != null
                          ? CircleAvatar(
                              radius: 98,
                              backgroundImage: FileImage(
                                File(currentImage!.path),
                              ),
                            )
                          : CircleAvatar(
                              radius: 98,
                              backgroundImage: widget.data['photo_url'] == null
                                  ? null
                                  : NetworkImage(widget.data['photo_url']),
                            ),
                    ),
                  ),
                  Positioned(
                    bottom: screenHiegrh * .045,
                    right: screenWidgth * .225,
                    child: CircleAvatar(
                      backgroundColor: AppColors.primary,
                      child: GestureDetector(
                        onTap: () async {
                          final ImagePicker _picker = ImagePicker();
                          final XFile? image = await _picker.pickImage(
                              source: ImageSource.gallery);
                          if (image != null) {
                            setState(() {
                              currentImage = image;
                            });
                          }
                        },
                        child: const Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                width: screenWidgth * .9,
                child: Column(
                  children: [
                    AppInput(
                      controller: _emailController,
                      label: "Email",
                      readOnly: true,
                    ),
                    SizedBox(
                      height: screenHiegrh * .002,
                    ),
                    AppInput(
                      controller: _nameController,
                      label: "Name",
                    ),
                    SizedBox(
                      height: screenHiegrh * .002,
                    ),
                    AppInput(
                      controller: _subnameController,
                      label: "Subname",
                    ),
                    SizedBox(
                      height: screenHiegrh * .002,
                    ),
                    AppInput(
                      controller: _telController,
                      label: "Phone",
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
                    BlocBuilder<UserCubit, UserState>(
                      builder: (contexte, state) {
                        return AppButton(
                          text: "Save change",
                          onTap: () async {
                            try {
                              setState(() {
                                isLoading = true;
                              });
                              var data = await getData();
                              await UserService()
                                  .updateAccount(widget.id, data);
                              setState(() {
                                isLoading = false;
                              });
                              Navigator.of(context).pop();
                              contexte
                                  .read<UserCubit>()
                                  .getAuthenticatedUser(widget.id);
                            } catch (e) {
                              print(e);
                              setState(() {
                                isLoading = false;
                              });
                            }
                          },
                        );
                      },
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
