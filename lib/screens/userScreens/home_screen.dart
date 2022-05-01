import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media/providers/feed_provider.dart';
import 'package:social_media/screens/login_screen.dart';
import 'package:social_media/screens/postScreens/post_screen_handler.dart';
import 'package:social_media/utilities/auth_helper.dart';

import '../../widgets/post_card.dart';

class HomeScreen extends StatefulWidget {
  User user;

  HomeScreen(this.user);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    FeedProvider provider = Provider.of<FeedProvider>(context);

    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => PostScreen()));
                },
                icon: Icon(Icons.add_box_outlined)),
            IconButton(onPressed: () {}, icon: Icon(Icons.toc))
          ],
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () async {
              await AuthHelper.signOut();
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => LoginScreen()));
            },
          ),
        ),
        body: StreamBuilder(
            stream: provider.verifiedFeed,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {

              if (snapshot.hasError) {
                return Text('Something went wrong');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot data = snapshot.data!.docs[index];
                    print(snapshot.data!.docs.length);
                    return Post(
                        data['postUrl'], data['caption'], data['name']);
                  });
            }),
    );
  }
}
