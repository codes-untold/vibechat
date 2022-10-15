import 'package:flutter/material.dart';
import 'package:flutter_task/utilities/styles.dart';

import '../../models/user_data_model.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen(this.data, {Key? key}) : super(key: key);
  UserDataModel data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Image.asset(
                      "assets/${data.imgName}.png",
                      width: 120,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Styles.bold(data.displayName, fontSize: 25),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          "assets/profile_action1.png",
                          width: 40,
                        ),
                        Image.asset(
                          "assets/profile_action2.png",
                          width: 40,
                        ),
                        Image.asset(
                          "assets/profile_action3.png",
                          width: 40,
                        ),
                        Image.asset(
                          "assets/profile_action4.png",
                          width: 40,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Styles.regular("Color", fontSize: 15),
                      Image.asset(
                        "assets/oval_blue.png",
                        width: 20,
                      )
                    ],
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Styles.regular("Emoji", fontSize: 15),
                      Image.asset(
                        "assets/like_blue.png",
                        width: 20,
                      )
                    ],
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Styles.regular("Nicknames"),
                      const Icon(
                        Icons.arrow_forward_ios,
                        color: Color(0x33000000),
                        size: 15,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  Row(
                    children: [
                      Styles.regular(
                        "MORE ACTIONS",
                        color: Color(0x33000000),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Styles.regular("Search in Convertsation"),
                      const CircleAvatar(
                        radius: 15,
                        backgroundColor: Color(0x0d000000),
                        child: Icon(
                          Icons.search,
                          color: Colors.black,
                          size: 15,
                        ),
                      )
                    ],
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Styles.regular("Create Group"),
                      const CircleAvatar(
                        radius: 15,
                        backgroundColor: Color(0x0d000000),
                        child: Icon(
                          Icons.people,
                          color: Colors.black,
                          size: 15,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  Row(
                    children: [
                      Styles.regular(
                        "PRIVACY",
                        color: Color(0x33000000),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Styles.regular("Notifications"),
                      Row(
                        children: [
                          Styles.regular("On", color: const Color(0x33000000)),
                          const SizedBox(
                            width: 3,
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: Color(0x33000000),
                            size: 15,
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Styles.regular("Ignore Messages"),
                      Image.asset(
                        "assets/ignore_icon.png",
                        width: 30,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Styles.regular("Block"),
                    ],
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back_ios,
                color: Color((0xff3238b8)),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
