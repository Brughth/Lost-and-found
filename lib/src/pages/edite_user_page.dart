import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lost_and_found/src/services/user_services.dart';
import 'package:lost_and_found/src/widget/app_button.dart';
import 'package:lost_and_found/src/widget/app_imput.dart';

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
  late UserService _userService;
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
    _userService = UserService();
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
    Map<String, dynamic> data = Map();
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
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: const Color(0xFF212121),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF909093)),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ListView(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              color: Color(0xFF212121),
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Stack(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: CircleAvatar(
                        radius: 100,
                        backgroundColor: const Color(0xFFff7521),
                        child: currentImage != null
                            ? CircleAvatar(
                                radius: 98,
                                backgroundImage: FileImage(
                                  File(currentImage!.path),
                                ),
                              )
                            : CircleAvatar(
                                radius: 98,
                                backgroundImage: NetworkImage(
                                    widget.data['photo_url'] ?? ''),
                              ),
                      ),
                    ),
                    Positioned(
                      top: 130,
                      left: 270,
                      child: CircleAvatar(
                        backgroundColor: const Color(0xFFffffff),
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
                            color: Color(0xFFff7521),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 330,
                  child: Column(
                    children: [
                      AppImput(
                        controller: _emailController,
                        hintText: "Email",
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      AppImput(
                        controller: _nameController,
                        hintText: "Nom",
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      AppImput(
                        controller: _subnameController,
                        hintText: "Prenom",
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      AppImput(
                        controller: _telController,
                        hintText: "Tel",
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
                      const SizedBox(
                        height: 20,
                      ),
                      AppButton(
                        text: "Enregistrer",
                        firstColor: const Color(0xFFff7521),
                        secondColor: const Color(0xFFffb421),
                        onTap: () async {
                          try {
                            setState(() {
                              isLoading = true;
                            });
                            var data = await getData();
                            await UserService().updateAccount(widget.id, data);
                            setState(() {
                              isLoading = false;
                            });
                          } catch (e) {
                            print(e);
                            setState(() {
                              isLoading = false;
                            });
                          }
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
