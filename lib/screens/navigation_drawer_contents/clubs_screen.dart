import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media/providers/clubs_screen_provider.dart';


class ClubScreen extends StatelessWidget {
  const ClubScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    ClubsProvider provider = Provider.of<ClubsProvider>(context);

    return StreamBuilder<QuerySnapshot>(
        stream: provider.clubsStream,
        builder:
            (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Something went wrong'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
              document.data()! as Map<String, dynamic>;
              return ListTile(title: Text(data['name']),);
            }).toList(),
          );
        });
  }
}
