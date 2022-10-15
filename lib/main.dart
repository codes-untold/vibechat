import 'package:flutter/material.dart';
import 'package:flutter_task/controller/chat_controller.dart';
import 'package:flutter_task/views/chat_screen.dart';
import 'package:flutter_task/views/screens/home_screen.dart';
import 'package:flutter_task/views/screens/navigation_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider<ChatController>(
    create: (context) => ChatController(),
    child: MaterialApp(
      home: NavigationScreen(),
    ),
  ));
}
