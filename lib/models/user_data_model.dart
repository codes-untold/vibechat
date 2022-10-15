import 'package:flutter_task/models/chat_model_mini.dart';

class UserDataModel {
  String displayName;
  int userID;
  String imgName;
  String lastMsg;
  String lastMsgTime;
  dynamic chattyList;

  UserDataModel(
      {required this.displayName,
      required this.userID,
      required this.imgName,
      this.lastMsg = "",
      this.lastMsgTime = "",
      required this.chattyList});

  Map toJson() => {
        "displayName": displayName,
        "userID": userID,
        "imgName": imgName,
        "lastMsg": lastMsg,
        "lastMsgTime": lastMsgTime,
        "chattyList": chattyList
      };

  static UserDataModel fromMap(Map<String, dynamic> json) => UserDataModel(
      displayName: json["displayName"],
      userID: json["userID"],
      imgName: json["imgName"],
      lastMsg: json["lastMsg"],
      lastMsgTime: json["lastMsgTime"],
      chattyList: (json["chattyList"]));
}
