import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media/screens/login_screen.dart';
import 'package:social_media/utilities/auth_helper.dart';

class HomeScreen extends StatelessWidget {

  User user;

  HomeScreen(this.user);

  // static String homeScreenRoute = '/home_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () async {
            await AuthHelper.signOut();
            Navigator.pushReplacement(context, MaterialPageRoute(builder:(_)=>LoginScreen()));
          },
        ),
      ),
      body: Center(
        child: Text("Welcome!"),
      ),
    );
  }
}
