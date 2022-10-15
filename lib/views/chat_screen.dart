import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_task/controller/chat_controller.dart';
import 'package:flutter_task/controller/storage.dart';
import 'package:flutter_task/models/chat_model_mini.dart';
import 'package:flutter_task/models/user_data_model.dart';
import 'package:flutter_task/utilities/constants.dart';
import 'package:flutter_task/utilities/styles.dart';
import 'package:flutter_task/views/screens/profile_screen.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  UserDataModel data;
  ChatScreen(this.data);
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();

  String? messageText;

  @override
  void initState() {
    super.initState();
    print(widget.data.chattyList.length);
    ChatController chatController = Provider.of(context, listen: false);
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      chatController.clearchat();
      if (widget.data.chattyList.isNotEmpty) {
        for (int i = 0; i < widget.data.chattyList.length; i++) {
          chatController.chatList.add(ChatModelMinix(
              sender: widget.data.chattyList[i]["sender"],
              text: widget.data.chattyList[i]["text"],
              isMe: widget.data.chattyList[i]["isMe"],
              timeStamp: widget.data.chattyList[i]["timeStamp"]));
        }

        chatController.refreshController(time: 1);
      }
    });
  }

  void sendProcedure(String sentText, bool isMe) {
    ChatController chatController = Provider.of(context, listen: false);
    chatController.addMessages(ChatModelMinix(
        sender: sentText,
        text: sentText,
        isMe: isMe,
        timeStamp: DateTime.now().millisecondsSinceEpoch));

    List<ChatModelMini> newList = [];
    for (int i = 0; i < chatController.chatList.length; i++) {
      newList.add(ChatModelMini(
          sender: chatController.chatList[i].sender,
          text: chatController.chatList[i].text,
          isMe: chatController.chatList[i].isMe,
          timeStamp: chatController.chatList[i].timeStamp));
    }

    print(DateFormat.Hm().format(DateTime.now()));
    UserDataModel newModel = UserDataModel(
        displayName: widget.data.displayName,
        lastMsg: sentText,
        lastMsgTime: DateTime.now().millisecondsSinceEpoch.toString(),
        userID: widget.data.userID,
        imgName: widget.data.imgName,
        chattyList: newList.map((e) => e.toJson()).toList());

    chatController.userDataList
        .removeWhere((element) => element.userID == widget.data.userID);

    chatController.userDataList.add(newModel);

    List<String> encodedList = [];
    for (int i = 0; i < chatController.userDataList.length; i++) {
      encodedList.add(jsonEncode(chatController.userDataList[i].toJson()));
    }

    Storage.setStringList(userKey, encodedList);

    print(chatController.userDataList[0].chattyList.length);
    print("PPPPAAATTTHHHH");
    print(chatController.chatList.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Card(
              margin: EdgeInsets.zero,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(
                              Icons.arrow_back_ios,
                              color: Color(0xff0061ff),
                            ),
                          ),
                          const SizedBox(width: 7.5),
                          Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ProfileScreen(widget.data)));
                                },
                                child: Image.asset(
                                  "assets/${widget.data.imgName}.png",
                                  width: 35,
                                ),
                              ),
                              const CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 6,
                                child: CircleAvatar(
                                  backgroundColor: Color(0xff5AD439),
                                  radius: 5,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 6.5),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Styles.bold(widget.data.displayName,
                                  fontSize: 14),
                              Styles.regular("Online",
                                  fontSize: 12,
                                  color: Color.fromARGB(255, 82, 82, 82))
                            ],
                          )
                        ],
                      ),
                    ),
                    Row(
                      children: const [
                        Icon(
                          Icons.phone,
                          color: Color(0xff0016ff),
                          size: 20,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(Icons.videocam_rounded, color: Color(0xff0016ff))
                      ],
                    )
                  ],
                ),
              ),
            ),
            MessagesStream(widget.data),
            Container(
              height: 60,
              padding: const EdgeInsets.all(8),
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: [
                  Image.asset(
                    "assets/Shape.png",
                    width: 20,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Image.asset(
                    "assets/Shape-2.png",
                    width: 20,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Image.asset(
                    "assets/Shape-3.png",
                    width: 20,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Image.asset(
                    "assets/Shape-4.png",
                    width: 20,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: messageTextController,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      onFieldSubmitted: (value) {
                        if (value.isEmpty) {
                          return;
                        }
                        String sentText = messageTextController.text;
                        ChatController chatController =
                            Provider.of(context, listen: false);

                        sendProcedure(sentText, true);

                        Future.delayed(const Duration(seconds: 2), () {
                          sendProcedure(sentText, false);
                        });

                        messageTextController.clear();
                      },
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        isDense: true,
                        isCollapsed: true,
                        fillColor: const Color(0xfffafbfc),
                        filled: true,
                        hintText: "Aa",
                        hintStyle: const TextStyle(fontSize: 14),
                        suffixIconConstraints: const BoxConstraints.tightFor(
                            width: 30, height: 30),
                        suffixIcon: const Icon(
                          Icons.emoji_emotions,
                          size: 30,
                          color: Color(0xff0016ff),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Image.asset(
                    "assets/Shape-5.png",
                    width: 20,
                  ),
                ],
              ),
            )
            /* Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      messageTextController.clear();
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}

class MessagesStream extends StatelessWidget {
  UserDataModel data;
  MessagesStream(this.data);
  @override
  Widget build(BuildContext context) {
    return Consumer<ChatController>(builder: ((context, chatController, _) {
      return Expanded(
          child: ListView.builder(
        reverse: true,
        controller: chatController.controller,
        itemBuilder: ((context, index) => MessageBubble(
              sender: chatController.chatList[index].sender,
              text: chatController.chatList[index].text,
              isMe: chatController.chatList[index].isMe,
              data: data,
            )),
        itemCount: chatController.chatList.length,
      ));
    }));
  }
}

class MessageBubble extends StatelessWidget {
  MessageBubble({this.sender, this.text, this.isMe, this.data});

  final String? sender;
  final String? text;
  final bool? isMe;
  final UserDataModel? data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe! ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              isMe!
                  ? const SizedBox.shrink()
                  : Row(
                      children: [
                        Image.asset(
                          "assets/${data!.imgName}.png",
                          width: 15,
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                      ],
                    ),
              Material(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                elevation: 5.0,
                color: isMe! ? const Color(0xff0061ff) : Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 20.0),
                  child: Text(
                    text!,
                    style: TextStyle(
                      color: isMe! ? Colors.white : Colors.black54,
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ),
              isMe!
                  ? Row(
                      children: const [
                        SizedBox(
                          width: 1,
                        ),
                        Icon(
                          Icons.check_circle_outline_outlined,
                          color: Color(0xff0061ff),
                          size: 12,
                        ),
                      ],
                    )
                  : const SizedBox.shrink()
            ],
          ),
        ],
      ),
    );
  }
}
