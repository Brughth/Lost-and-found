import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lost_and_found/src/chat/chat_page.dart';
import 'package:lost_and_found/src/chat/chat_parans.dart';
import 'package:lost_and_found/src/utils/app_colors.dart';

class ConversationItem extends StatelessWidget {
  final String userId;
  final String peedId;
  final String userName;
  final String? userPhoto;
  final String? userSubName;
  final String userTel;
  final String updateAt;
  const ConversationItem({
    Key? key,
    required this.userId,
    required this.peedId,
    required this.userName,
    required this.userPhoto,
    required this.userSubName,
    required this.userTel,
    required this.updateAt,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ChatParams chatParams = ChatParams(
          userId: userId,
          peerId: peedId,
          peerName: userName,
        );
        //print("photo ${user['photo_url']}");
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ChatPage(chatParams: chatParams),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          children: [
            userPhoto == null
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
                      backgroundImage: NetworkImage(userPhoto!),
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
                        text: "$userName ",
                        style: const TextStyle(
                          color: AppColors.primaryText,
                          fontWeight: FontWeight.w700,
                          fontSize: 17,
                        ),
                        children: [
                          if (userSubName != null)
                            TextSpan(
                              text: userSubName,
                              style: const TextStyle(
                                color: AppColors.primaryText,
                                fontWeight: FontWeight.w700,
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
                          Text(
                            userTel,
                            style: const TextStyle(
                              color: AppColors.primaryText,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Text(
                              DateFormat.yMMMd()
                                  .format(DateTime.parse(updateAt)),
                              style: const TextStyle(
                                color: AppColors.primaryText,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
