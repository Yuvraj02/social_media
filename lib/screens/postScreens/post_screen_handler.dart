import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media/providers/post_screen_provider.dart';
import 'package:social_media/screens/postScreens/entity_post_screen.dart';
import 'package:social_media/screens/postScreens/student_posts_screen.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {

  @override
  Widget build(BuildContext context) {
    PostProvider provider = Provider.of<PostProvider>(context);
    provider.entityCheck();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("Post"),
      ),
      body:
      provider.isVerified == null
        //AuthHelper.isVerifiedEntity == null
          ? Center(child: CircularProgressIndicator())
          :provider.isVerified == true
              ? EntityPosts()
              : StudentPosts(),
    );
  }
}
