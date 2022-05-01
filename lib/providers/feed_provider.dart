import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class FeedProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<QuerySnapshot> verifiedFeed = FirebaseFirestore.instance
      .collection('posts')
      .orderBy('datePublished', descending: true)
      .snapshots();

  Stream<QuerySnapshot> studentFeed = FirebaseFirestore.instance
      .collection('student_posts')
      .orderBy('datePublished')
      .snapshots();
}
