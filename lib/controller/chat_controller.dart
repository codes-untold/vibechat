import 'package:flutter/material.dart';
import 'package:flutter_task/models/chat_model_mini.dart';

import '../models/user_data_model.dart';

class ChatController extends ChangeNotifier {
  List<UserDataModel> userDataList = [];

  List<ChatModelMinix> chatList = [];

  ScrollController controller = ScrollController();

  void _scrollDown() {
    controller.jumpTo(controller.position.minScrollExtent);
    notifyListeners();
  }

  void clearchat() {
    chatList.clear();
    notifyListeners();
  }

  void refreshController({int time = 1}) {
    Future.delayed(Duration(seconds: time), () {
      notifyListeners();
    });
  }

  void addMessages(ChatModelMinix chatModelMini) {
    chatList.insert(0, chatModelMini);
    _scrollDown();
    notifyListeners();
  }
}
