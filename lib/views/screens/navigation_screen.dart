import 'package:flutter/material.dart';
import 'package:flutter_task/views/recent_screen.dart';
import 'package:flutter_task/views/screens/home_screen.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({Key? key}) : super(key: key);

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int selectedIndex = 0;
  List<Widget> widgets = [HomeScreen(), RecentScreen(), Container()];

  void onItemTapped(int index) {
    if (index == 2) {
      return;
    }
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: widgets[selectedIndex]),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: selectedIndex == 0
                  ? Image.asset(
                      "assets/active_icon1.png",
                      width: 20,
                    )
                  : Image.asset(
                      "assets/inactive_icon1.png",
                      width: 20,
                    ),
              label: "chat"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.people,
                size: 30.0,
                color: selectedIndex == 1
                    ? const Color(0xff323b4b)
                    : const Color(0xffB0B7C3),
              ),
              label: "people"),
          const BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
                size: 20.0,
                color: const Color(0xffB0B7C3),
              ),
              label: "setting")
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: onItemTapped,
        selectedLabelStyle: TextStyle(color: Colors.white, fontSize: 1.0),
        unselectedLabelStyle: TextStyle(color: Colors.white, fontSize: 1.0),
      ),
    );
  }
}
