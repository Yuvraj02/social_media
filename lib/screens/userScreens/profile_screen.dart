import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Profile"),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 3,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.blue,
                ),
                Column(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.yellow,
                      radius: 60,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(_auth.currentUser!.displayName!),
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     ElevatedButton(
                    //         style: ButtonStyle(
                    //             backgroundColor:
                    //                 MaterialStateProperty.all(Colors.amber)),
                    //         onPressed: () {},
                    //         child: Text(
                    //           "Connect",
                    //           style: TextStyle(color: Colors.blueGrey),
                    //         )),
                    //     SizedBox(
                    //       width: 16,
                    //     ),
                    //     ElevatedButton(
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
              child: Text("Skills",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
            )

          ],
        ));
  }
}
