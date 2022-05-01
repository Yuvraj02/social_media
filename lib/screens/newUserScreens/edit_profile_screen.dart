import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media/screens/screens_handler.dart';

class EditProfileNewUser extends StatelessWidget {
  User user;

  EditProfileNewUser(this.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text("Edit profile"),
          onPressed: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => ScreenHandler()));
          },
        ),
      ),
    );
  }
}
