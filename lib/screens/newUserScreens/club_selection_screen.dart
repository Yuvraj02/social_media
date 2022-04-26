import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media/screens/newUserScreens/edit_profile_screen.dart';

class ClubSelectionNewUser extends StatelessWidget {

  User user;
  ClubSelectionNewUser(this.user);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text("Next"),
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_) => EditProfileNewUser(user)));
          },
        ),
      ),
    );
  }
}
