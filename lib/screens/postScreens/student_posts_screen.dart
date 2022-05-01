import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media/providers/post_screen_provider.dart';

class StudentPosts extends StatefulWidget {
  @override
  State<StudentPosts> createState() => _StudentPostsState();
}

class _StudentPostsState extends State<StudentPosts> {
  TextEditingController _captionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    PostProvider provider = Provider.of<PostProvider>(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: TextField(
                controller: _captionController,
                decoration: InputDecoration(
                    hintText: 'Enter Your Enquiry Here',
                    border: InputBorder.none),
              ),
            ),
            height: MediaQuery
                .of(context)
                .size
                .height / 6,
            width: MediaQuery
                .of(context)
                .size
                .width,
            decoration: BoxDecoration(border: Border.all(color: Colors.white)),
          ),
        ),
        IconButton(onPressed: () {
          provider.uploadStudentPost(caption: _captionController.text);
        }, icon: Icon(Icons.arrow_forward_outlined))
      ],
    );
  }
}
