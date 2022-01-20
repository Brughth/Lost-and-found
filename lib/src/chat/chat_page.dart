import 'package:flutter/material.dart';
import 'package:lost_and_found/src/chat/chat_parans.dart';
import 'package:lost_and_found/src/chat/message.dart';
import 'package:lost_and_found/src/chat/message_service.dart';
import 'package:lost_and_found/src/utils/app_colors.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lost_and_found/src/widget/message_item_widget.dart';

class ChatPage extends StatefulWidget {
  final ChatParams chatParams;
  const ChatPage({
    Key? key,
    required this.chatParams,
  }) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late TextEditingController _messageController;
  late ScrollController _scrollController;
  late MessageService _messageService;

  int nbElement = 20;
  int paginationincrement = 20;
  bool isLaoding = false;

  @override
  void initState() {
    _messageController = TextEditingController();
    _scrollController = ScrollController();
    _messageService = MessageService();
    _scrollController.addListener(scrollListernner);
    super.initState();
  }

  scrollListernner() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      setState(() {
        nbElement += paginationincrement;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // double screemHeight = MediaQuery.of(context).size.height;
    // double screemWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text(
          "chat with ${widget.chatParams.peerName}",
          style: const TextStyle(
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              builListMessage(),
              builImput(),
            ],
          ),
          isLaoding
              ? const Center(child: CircularProgressIndicator())
              : Container()
        ],
      ),
    );
  }

  Widget builListMessage() {
    return Flexible(
      child: StreamBuilder<List<Message>>(
        stream: _messageService.getMessages(
            widget.chatParams.getChatGroupId(), nbElement),
        builder: (BuildContext context, AsyncSnapshot<List<Message>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Text(
              snapshot.error.toString(),
              style: const TextStyle(color: Colors.red),
            );
          }
          if (snapshot.hasData) {
            List<Message> listMessage = snapshot.data ?? List.from(([]));

            return ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: listMessage.length,
              reverse: true,
              controller: _scrollController,
              itemBuilder: (context, index) => MessageItem(
                message: listMessage[index],
                userId: widget.chatParams.userId,
                isLAstMessage: isLastMessage(index, listMessage),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }

  bool isLastMessage(int index, List<Message> listMessage) {
    if (index == 0) return true;
    if (listMessage[index].idFrom != listMessage[index - 1].idFrom) return true;
    return false;
  }

  Widget builImput() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      decoration: const BoxDecoration(
        color: Color.fromRGBO(244, 243, 243, 1),
      ),
      child: TextField(
        minLines: 1,
        maxLines: 3,
        autofocus: false,
        controller: _messageController,
        style: const TextStyle(
          color: AppColors.primaryGrayText,
          fontSize: 18,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          suffixIcon: IconButton(
            onPressed: () {
              if (_messageController.text.isNotEmpty ||
                  _messageController.text != "") {
                _messageService.onSendMessage(
                  chatParams: widget.chatParams,
                  message: Message(
                    idFrom: widget.chatParams.userId,
                    idTo: widget.chatParams.peerId,
                    timestamp: DateTime.now().microsecondsSinceEpoch.toString(),
                    content: _messageController.text,
                  ),
                );

                _scrollController.animateTo(
                  0.0,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );

                _messageController.clear();
              } else {
                Fluttertoast.showToast(
                  msg: "Nothing to send...",
                  backgroundColor: AppColors.primary,
                  textColor: Colors.white,
                );
              }
            },
            icon: const Icon(
              Icons.send,
              color: AppColors.primary,
            ),
          ),
          prefix: Container(
            width: 10,
          ),
          hintText: "Type message...",
          hintStyle: const TextStyle(
            color: AppColors.grayScale,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
    );
  }
}
