import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_task/controller/chat_controller.dart';
import 'package:flutter_task/controller/storage.dart';
import 'package:flutter_task/models/user_data_model.dart';
import 'package:flutter_task/models/user_model.dart';
import 'package:flutter_task/utilities/constants.dart';
import 'package:flutter_task/utilities/styles.dart';
import 'package:flutter_task/views/chat_screen.dart';
import 'package:flutter_task/views/screens/widgets/chat_head.dart';
import 'package:flutter_task/views/screens/widgets/chat_tab.dart';
import 'package:flutter_task/views/screens/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<UserDataModel> userList = [
    UserDataModel(
        displayName: "mike", userID: 111, imgName: "mike", chattyList: []),
    UserDataModel(
        displayName: "tony", userID: 222, imgName: "tony", chattyList: []),
    UserDataModel(
        displayName: "sandra", userID: 333, imgName: "sandra", chattyList: []),
    UserDataModel(
        displayName: "ben", userID: 444, imgName: "ben", chattyList: []),
    UserDataModel(
        displayName: "peter", userID: 555, imgName: "peter", chattyList: []),
  ];

  @override
  void initState() {
    super.initState();
    ChatController chatController = Provider.of(context, listen: false);
    chatController.userDataList.clear();

    Storage.getStringList(userKey).then((value) {
      if (value == null) {
        return;
      }

      if (value.isNotEmpty) {
        for (int i = 0; i < value.length; i++) {
          chatController.userDataList
              .add(UserDataModel.fromMap(jsonDecode(value[i])));
        }
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatController>(
      builder: ((context, chatController, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            "assets/user_avatar.png",
                            width: 30,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Styles.bold("Chats")
                        ],
                      ),
                      Row(
                        children: [
                          Image.asset(
                            "assets/take_photo.png",
                            width: 30,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Image.asset(
                            "assets/new_message.png",
                            width: 30,
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const CustomTextfield(),
                  const SizedBox(
                    height: 15,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Column(
                          children: [
                            const CircleAvatar(
                              backgroundColor: Color(0xfff4f5f7),
                              radius: 25,
                              child: Icon(
                                Icons.add,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Styles.regular("Your Story",
                                color: const Color(0x33000000), fontSize: 12)
                          ],
                        ),
                        Row(
                          children: List.generate(
                              userList.length,
                              (index) => GestureDetector(
                                  onTap: () {
                                    if (chatController.userDataList.isEmpty) {
                                      chatController.userDataList
                                          .add(userList[index]);

                                      String encodedData =
                                          jsonEncode(userList[index].toJson());

                                      List<String> encodedList = [encodedData];

                                      Storage.setStringList(
                                          userKey, encodedList);

                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ChatScreen(userList[index])));

                                      chatController.refreshController();
                                    } else {
                                      UserDataModel? selectedUserData;
                                      for (int i = 0;
                                          i <
                                              chatController
                                                  .userDataList.length;
                                          i++) {
                                        if (chatController
                                                .userDataList[i].userID ==
                                            userList[index].userID) {
                                          selectedUserData =
                                              chatController.userDataList[i];
                                        }
                                      }

                                      chatController.userDataList.removeWhere(
                                          (element) =>
                                              element.userID ==
                                              userList[index].userID);

                                      chatController.userDataList.add(
                                          selectedUserData ?? userList[index]);

                                      List<String> encodedList = [];
                                      for (int i = 0;
                                          i <
                                              chatController
                                                  .userDataList.length;
                                          i++) {
                                        encodedList.add(jsonEncode(
                                            chatController.userDataList[i]
                                                .toJson()));
                                      }

                                      Storage.setStringList(
                                          userKey, encodedList);

                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => ChatScreen(
                                                  selectedUserData ??
                                                      userList[index])));
                                      chatController.refreshController();
                                    }
                                  },
                                  child: ChatHead(userList[index]))),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  chatController.userDataList.isNotEmpty
                      ? Column(
                          children: List.generate(
                              chatController.userDataList.length,
                              (index) => GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ChatScreen(
                                                chatController
                                                    .userDataList[index])));
                                  },
                                  child: Slidable(
                                    key: ValueKey(index),
                                    startActionPane: ActionPane(
                                      motion: const ScrollMotion(),
                                      //  dismissible: DismissiblePane(onDismissed: () {}),
                                      children: [
                                        Expanded(
                                            child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: const [
                                            CircleAvatar(
                                              backgroundColor:
                                                  Color(0xff0084fe),
                                              child: Icon(
                                                Icons.camera_alt,
                                                color: Colors.white,
                                                size: 20,
                                              ),
                                            ),
                                            CircleAvatar(
                                              backgroundColor:
                                                  Color(0x0d000000),
                                              child: Icon(
                                                Icons.call,
                                                color: Colors.black,
                                                size: 20,
                                              ),
                                            ),
                                            CircleAvatar(
                                              backgroundColor:
                                                  Color(0x0d000000),
                                              child: Icon(
                                                Icons.videocam,
                                                color: Colors.black,
                                                size: 20,
                                              ),
                                            ),
                                          ],
                                        )),
                                      ],
                                    ),
                                    endActionPane: ActionPane(
                                      motion: const ScrollMotion(),
                                      //  dismissible: DismissiblePane(onDismissed: () {}),
                                      children: [
                                        Expanded(
                                            child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: const [
                                            CircleAvatar(
                                              backgroundColor:
                                                  Color(0x0d000000),
                                              child: Icon(
                                                Icons.menu,
                                                color: Colors.black,
                                                size: 20,
                                              ),
                                            ),
                                            CircleAvatar(
                                              backgroundColor:
                                                  Color(0x0d000000),
                                              child: Icon(
                                                Icons.notifications,
                                                color: Colors.black,
                                                size: 20,
                                              ),
                                            ),
                                            CircleAvatar(
                                              backgroundColor: Colors.red,
                                              child: Icon(
                                                Icons.delete,
                                                color: Colors.white,
                                                size: 20,
                                              ),
                                            ),
                                          ],
                                        )),
                                      ],
                                    ),
                                    child: ChatTab(
                                        chatController.userDataList[index]),
                                  ))),
                        )
                      : Expanded(
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset("assets/inactive_icon1.png"),
                                const SizedBox(
                                  height: 10,
                                ),
                                Styles.bold("No Chats yet")
                              ],
                            ),
                          ),
                        )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
