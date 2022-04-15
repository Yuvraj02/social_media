import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media/screens/clubs_screen.dart';
import 'package:social_media/screens/events_screen.dart';
import 'package:social_media/screens/login_screen.dart';
import 'package:social_media/screens/profile_screen.dart';
import 'package:social_media/screens/search_screen.dart';
import 'package:social_media/utilities/auth_helper.dart';

class HomeScreen extends StatefulWidget {
  User user;

  HomeScreen(this.user);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // int currentIndex = 0;
  // final screens = [
  //    // HomeScreen(),
  //    SearchScreen(),
  //    ClubScreen(),
  //    EventScreen(),
  //    ProfileScreen(),
  //
  // ];

  void _push(BuildContext context, Widget screen) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => screen));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () async {
            await AuthHelper.signOut();
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => LoginScreen()));
          },
        ),
      ),
      body: Text("Good"),
    );
  }
}
