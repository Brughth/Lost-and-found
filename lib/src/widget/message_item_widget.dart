import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lost_and_found/src/chat/message.dart';
import 'package:lost_and_found/src/utils/app_colors.dart';

class MessageItem extends StatelessWidget {
  final Message message;
  final String userId;
  final bool isLAstMessage;
  const MessageItem({
    Key? key,
    required this.message,
    required this.userId,
    required this.isLAstMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: userId == message.idFrom
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: userId == message.idFrom
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            Container(
              child: Text(
                message.content,
                style: TextStyle(
                  color: userId == message.idFrom ? Colors.black : Colors.white,
                ),
              ),
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
              width: 200,
              decoration: BoxDecoration(
                color: userId == message.idFrom ? Colors.grey : Colors.blueGrey,
                borderRadius: BorderRadius.circular(8.0),
              ),
              margin: EdgeInsets.only(
                  bottom: isLAstMessage ? 20.0 : 10.0, right: 10, left: 10),
            ),
          ],
        ),
        isLAstMessage
            ? Container(
                child: Text(
                  DateFormat("dd MMM kk:mm").format(
                      DateTime.fromMicrosecondsSinceEpoch(
                          int.parse(message.timestamp))),
                  style: const TextStyle(
                    color: AppColors.primaryText,
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                margin: const EdgeInsets.only(
                  left: 15.0,
                  right: 15.0,
                  bottom: 5.0,
                ),
              )
            : Container(),
      ],
    );
  }
}
