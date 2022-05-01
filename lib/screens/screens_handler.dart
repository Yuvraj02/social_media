import 'package:flutter/material.dart';
import 'package:social_media/screens/userScreens/profile_screen.dart';
import 'package:social_media/screens/userScreens/students_discussion_screen.dart';
import 'package:social_media/utilities/auth_helper.dart';
import 'eventScreens/events_screen.dart';
import 'searchScreen/search_screen.dart';
import 'userScreens/home_screen.dart';

class ScreenHandler extends StatefulWidget {
  const ScreenHandler({Key? key}) : super(key: key);

  @override
  State<ScreenHandler> createState() => _ScreenHandlerState();
}

class _ScreenHandlerState extends State<ScreenHandler> {

  int currentIndex = 0;
  final screens = [
    HomeScreen(AuthHelper.user),
    SearchScreen(),
    StudentsPage(),
    EventScreen(),
    ProfileScreen(),
  ];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AuthHelper.entityCheck();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index)=> setState(() => currentIndex = index),
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        iconSize: 30,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_rounded),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_outlined),
            label: 'Clubs',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_fire_department),
            label: 'Events',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
