import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media/models/user_model.dart';
import 'package:social_media/providers/user_details_provider.dart';
import 'package:social_media/widgets/user_profile_screen.dart';

class SearchedUserProfileScreen extends StatefulWidget {
  User user;

  SearchedUserProfileScreen(this.user);

  @override
  State<SearchedUserProfileScreen> createState() =>
      _SearchedUserProfileScreenState();
}

class _SearchedUserProfileScreenState extends State<SearchedUserProfileScreen> {
  String followOrUnfollow = "Follow";
  bool? following;


  @override
  Widget build(BuildContext context) {
    UserDetailsProvider provider = Provider.of<UserDetailsProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.user.userName),
        ),
        body: widget.user==null?CircularProgressIndicator():StreamBuilder(
            stream: provider.userProfile(widget.user.uid),
            builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator(),);
              }
              User userDocument = User.fromJson(snapshot.data!.data() as Map<String,dynamic>);

              return UserProfile(widget.user,provider);
            }));
  }
}
