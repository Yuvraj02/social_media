import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_media/models/user_model.dart';
import 'package:social_media/providers/user_details_provider.dart';
import 'package:social_media/utilities/auth_helper.dart';

class UserProfile extends StatelessWidget {
  UserModel user;
  UserProfile(this.user);

  @override
  Widget build(BuildContext context) {
    return user == null
        ? CircularProgressIndicator()
        : SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 3,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      )),
                ),
                Column(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.yellow,
                      radius: 60,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(user.name!),
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     //Check if user searched itself or not
                    //     user.uid==AuthHelper.UID?SizedBox():ElevatedButton(
                    //         style: ButtonStyle(
                    //             backgroundColor:
                    //                 MaterialStateProperty.all(Colors.blueGrey)),
                    //         onPressed: () {},
                    //         child: Text("Message"))
                    //   ],
                    // ),
                  ],
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                  child: Text(
                "There are 10 types of people in this world, those who understand binary and those who do not",
                style: TextStyle(fontSize: 16),
              )),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    color: Colors.pinkAccent,
                    height: 80,
                    width: 80,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    color: Colors.indigoAccent,
                    height: 80,
                    width: 80,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    color: Colors.greenAccent,
                    height: 80,
                    width: 80,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Skills",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Dart,C++,IOT"),
            ),
          ]));
  }
}
