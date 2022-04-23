import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class FeedProvider extends ChangeNotifier {
  Stream<QuerySnapshot> postStream = FirebaseFirestore.instance
      .collection('posts')
      .orderBy('datePublished', descending: true)
      .snapshots();

  // List<Post> posts = [];
  //
  //  Future getData() async {
  //
  //   try {
  //     FirebaseFirestore.instance
  //         .collection('posts').orderBy('datePublished',descending: true)
  //         .get()
  //         .then((QuerySnapshot querySnapshot) {
  //       for (var doc in querySnapshot.docs) {
  //         //  print("${doc['postUrl']},${doc['caption']},${doc['name']}");
  //         posts.add(Post(postUrl: doc['postUrl'],
  //             postID: doc['postID'],
  //             caption: doc['caption'],
  //             uid: doc['uid'],
  //             name: doc['name'],
  //             date: doc['datePublished']));
  //       }
  //     });
  //   } catch (err) {
  //     print(err);
  //   }
  // notifyListeners();
  // }

}
