import 'package:flutter/material.dart';
import 'package:flutter_task/models/user_data_model.dart';
import 'package:intl/intl.dart';

import '../../../utilities/styles.dart';

class ChatTab extends StatelessWidget {
  ChatTab(this.data, {Key? key}) : super(key: key);
  UserDataModel data;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/${data.imgName}.png",
              width: 50,
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Styles.semiBold(data.displayName),
                  const SizedBox(
                    height: 3,
                  ),
                  Row(
                    children: [
                      Styles.regular(data.lastMsg,
                          color: const Color(0xff8A8486), fontSize: 12),
                      data.lastMsgTime.isEmpty
                          ? const SizedBox.shrink()
                          : Row(
                              children: [
                                const SizedBox(
                                  width: 5,
                                ),
                                const CircleAvatar(
                                  backgroundColor: Colors.grey,
                                  radius: 1,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Styles.regular(
                                    DateFormat.Hm().format(
                                        DateTime.fromMillisecondsSinceEpoch(
                                            int.parse(data.lastMsgTime))),
                                    color: const Color(0xff8A8486),
                                    fontSize: 10),
                              ],
                            ),
                    ],
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.check_circle_outline_rounded,
              color: Color(0xff979797),
              size: 15,
            )
          ],
        ),
      ),
    );
  }
}
