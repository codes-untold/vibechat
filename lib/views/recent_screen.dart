import 'package:flutter/material.dart';
import 'package:flutter_task/controller/chat_controller.dart';
import 'package:flutter_task/views/screens/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';

import '../utilities/styles.dart';
import 'chat_screen.dart';

class RecentScreen extends StatelessWidget {
  const RecentScreen({Key? key}) : super(key: key);

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
                crossAxisAlignment: CrossAxisAlignment.start,
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
                          Styles.bold("People")
                        ],
                      ),
                      Row(
                        children: [
                          Image.asset(
                            "assets/message_btn.png",
                            width: 30,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Image.asset(
                            "assets/add_contact.png",
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
                    height: 30,
                  ),
                  Styles.regular("RECENTLY ACTIVE",
                      color: const Color(0x33000000), fontSize: 12),
                  const SizedBox(
                    height: 15,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: ((context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ChatScreen(
                                        chatController.userDataList[index])));
                          },
                          child: Container(
                            color: Colors.transparent,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/${chatController.userDataList[index].imgName}.png",
                                    width: 50,
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(
                                    child: Styles.semiBold(chatController
                                        .userDataList[index].displayName),
                                  ),
                                  Image.asset(
                                    "assets/Wave.png",
                                    width: 30,
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                      itemCount: chatController.userDataList.length,
                      shrinkWrap: true,
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
