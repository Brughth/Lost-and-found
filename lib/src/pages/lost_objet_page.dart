import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lost_and_found/src/pages/add_lost_objet_page.dart';
import 'package:lost_and_found/src/utils/app_colors.dart';
import 'package:lost_and_found/src/widget/objet_widget.dart';

class LostObjePage extends StatefulWidget {
  const LostObjePage({Key? key}) : super(key: key);

  @override
  _LostObjePageState createState() => _LostObjePageState();
}

class _LostObjePageState extends State<LostObjePage>
    with AutomaticKeepAliveClientMixin {
  late List<QueryDocumentSnapshot> data;
  int limit = 3;
  bool hasMore = false;
  bool isLoading = false;
  final int increment_limit = 5;
  late ScrollController scrollController;

  @override
  void initState() {
    scrollController = ScrollController();

    scrollController.addListener(scrollListernner);
    super.initState();
  }

  scrollListernner() {
    setState(() {
      isLoading = true;
    });
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      setState(() {
        limit += increment_limit;
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeigth = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("lost_objet")
                  .orderBy("createdAt", descending: true)
                  .limit(limit)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      "${snapshot.error}",
                      style: const TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  );
                }
                if (snapshot.hasData) {
                  data = snapshot.data!.docs;

                  if (snapshot.data!.size == 0) {
                    return const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          "No lost objet yet",
                          style: TextStyle(
                            color: AppColors.primaryText,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    );
                  } else {
                    return ListView.separated(
                      controller: scrollController,
                      itemCount: snapshot.data!.size,
                      separatorBuilder: (context, index) {
                        return Container(
                          height: screenHeigth * 0.01,
                          decoration:
                              const BoxDecoration(color: AppColors.grayScale),
                        );
                      },
                      itemBuilder: (context, index) {
                        var object = data[index];

                        return ObjetWidget(
                          title: object['title'],
                          description: object['description'],
                          image: object['image'],
                          userId: object['user_id'],
                          userImage: object['user_photo'],
                          username: object['user_name'],
                          createAd: object['createdAt'],
                          usersubname: object['user_subname'],
                          isLost: true,
                        );
                      },
                    );
                  }
                }
                return Container();
              },
            ),
          ),
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : Container(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "btn 1",
        backgroundColor: AppColors.primary,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddLostObjetPage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
