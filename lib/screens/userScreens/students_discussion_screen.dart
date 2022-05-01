import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media/providers/feed_provider.dart';
import 'package:social_media/screens/postScreens/only_students_section.dart';
import '../../widgets/post_card.dart';

class StudentsPage extends StatelessWidget {
  const StudentsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    FeedProvider provider = Provider.of<FeedProvider>(context);
    return Scaffold(appBar: AppBar(
      actions: [
        IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => StudentsOnlyPostScreen()));
            },
            icon: Icon(Icons.add_box_outlined)),
        IconButton(onPressed: () {}, icon: Icon(Icons.toc))
      ],
    ),
      body: StreamBuilder(
          stream: provider.studentFeed,
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
