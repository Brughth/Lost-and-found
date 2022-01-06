import 'package:flutter/material.dart';
import 'package:lost_and_found/src/pages/add_found_objet_page.dart';
import 'package:lost_and_found/src/utils/app_colors.dart';

class FoundObjetPage extends StatefulWidget {
  const FoundObjetPage({Key? key}) : super(key: key);

  @override
  _FoundObjetPageState createState() => _FoundObjetPageState();
}

class _FoundObjetPageState extends State<FoundObjetPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: const Center(
        child: Text("Found Objet Page"),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddFoundObjetPage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
