import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lost_and_found/src/authentification/auth_service.dart';
import 'package:lost_and_found/src/pages/found_objet_page.dart';
import 'package:lost_and_found/src/pages/lost_objet_page.dart';
import 'package:lost_and_found/src/pages/user_page.dart';
import 'package:lost_and_found/src/utils/app_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AuthServices _authServices;
  int currentPage = 0;
  late TabController _tabController;
  @override
  void initState() {
    _authServices = AuthServices();
    _tabController = TabController(vsync: this, length: 2);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        leading: IconButton(
          splashColor: AppColors.primary,
          onPressed: () {},
          icon: Icon(
            Icons.message,
            color: AppColors.hexToColor("ffffff"),
          ),
        ),
        title: const Text(
          "Lost And Found",
          style: TextStyle(
            color: AppColors.primaryGrayText,
            fontWeight: FontWeight.bold,
            fontSize: 23,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            splashColor: const Color(0xFFffb421),
            onPressed: () {},
            icon: Icon(
              Icons.search,
              color: AppColors.hexToColor("ffffff"),
            ),
          ),
          IconButton(
            splashColor: const Color(0xFFffb421),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const UserProfilePage(),
                ),
              );
            },
            icon: Icon(
              Icons.person,
              color: AppColors.hexToColor("ffffff"),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          TabBar(
            indicatorColor: AppColors.primary,
            unselectedLabelColor: AppColors.grayScale,
            labelColor: AppColors.primary,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.w700,
            ),
            controller: _tabController,
            tabs: const [
              Tab(
                text: "LOST OBJET",
              ),
              Tab(
                text: "FOUNT OBJET",
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                LostObjePage(),
                FoundObjetPage(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
