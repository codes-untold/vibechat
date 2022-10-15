import 'package:flutter/material.dart';
import 'package:flutter_task/models/user_data_model.dart';
import 'package:flutter_task/models/user_model.dart';
import 'package:flutter_task/utilities/styles.dart';

class ChatHead extends StatelessWidget {
  ChatHead(this.userModel, {Key? key}) : super(key: key);

  UserDataModel userModel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              Image.asset(
                "assets/${userModel.imgName}.png",
                width: 50,
              ),
              const CircleAvatar(
                backgroundColor: Colors.white,
                radius: 6,
                child: CircleAvatar(
                  backgroundColor: Color(0xff5AD439),
                  radius: 5,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Styles.regular(userModel.displayName, color: const Color(0x33000000))
        ],
      ),
    );
  }
}
