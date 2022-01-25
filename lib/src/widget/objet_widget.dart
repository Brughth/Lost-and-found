import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lost_and_found/src/chat/chat_page.dart';
import 'package:lost_and_found/src/chat/chat_parans.dart';
import 'package:lost_and_found/src/utils/app_colors.dart';
import 'package:readmore/readmore.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

class ObjetWidget extends StatelessWidget {
  final String title;
  final String userId;
  final String description;
  final String image;
  final String? userImage;
  final String username;
  final String? usersubname;
  final String createAd;
  final bool isLost;

  const ObjetWidget({
    Key? key,
    required this.title,
    required this.description,
    required this.image,
    required this.userId,
    required this.userImage,
    this.usersubname,
    required this.username,
    required this.createAd,
    this.isLost = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeigth = MediaQuery.of(context).size.height;
    double screenWidght = MediaQuery.of(context).size.width;
    String uid = FirebaseAuth.instance.currentUser!.uid;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              children: [
                (userImage == null || userImage!.isEmpty)
                    ? const CircleAvatar(
                        backgroundColor: AppColors.primary,
                        radius: 26,
                        child: CircleAvatar(
                          radius: 25,
                          backgroundColor: AppColors.secondary,
                        ),
                      )
                    : CircleAvatar(
                        backgroundColor: AppColors.primary,
                        radius: 26,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(userImage!),
                          radius: 25,
                        ),
                      ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: "$username ".toUpperCase(),
                            style: const TextStyle(
                              color: AppColors.primaryText,
                              fontWeight: FontWeight.w500,
                              fontSize: 17,
                            ),
                            children: [
                              TextSpan(
                                text: usersubname != null
                                    ? "$usersubname".toUpperCase()
                                    : "",
                                style: const TextStyle(
                                  color: AppColors.primaryText,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 0.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: screenWidght * .5,
                                child: Text(
                                  title.toUpperCase(),
                                  style: const TextStyle(
                                    color: AppColors.primaryText,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Text(
                                  DateFormat.yMMMd()
                                      .format(DateTime.parse(createAd)),
                                  style: const TextStyle(
                                    color: AppColors.primaryText,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Divider(
            color: AppColors.primary.withOpacity(.6),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7.0),
            child: ReadMoreText(
              description,
              trimLines: 2,
              style: const TextStyle(
                color: AppColors.primaryText,
                fontSize: 16,
              ),
              trimMode: TrimMode.Line,
              trimCollapsedText: 'Show more',
              trimExpandedText: 'Show less',
              moreStyle: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: AppColors.grayScale,
              ),
              lessStyle: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: AppColors.grayScale,
              ),
            ),
          ),
          SizedBox(
            height: screenHeigth * .01,
          ),
          Container(
            height: screenHeigth * .3,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: NetworkImage(image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.share,
                    color: AppColors.primary,
                  ),
                  onPressed: () async {
                    if (isLost) {
                      await Share.share("$title\n\n $description \n\n$image");
                    } else {
                      await Share.share("$title\n\n  $description \n\n$image");
                    }
                  },
                ),
                TextButton(
                  onPressed: () {
                    ChatParams chatParams = ChatParams(
                      userId: uid,
                      peerId: userId,
                      peerName: username,
                    );
                    if (userId != uid) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ChatPage(
                            chatParams: chatParams,
                          ),
                        ),
                      );
                    } else {
                      Fluttertoast.showToast(
                        msg: "Can't chat with you self",
                        backgroundColor: AppColors.primary,
                        textColor: Colors.white,
                      );
                    }
                  },
                  child: isLost
                      ? const Text("put it back")
                      : const Text("get it back"),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
