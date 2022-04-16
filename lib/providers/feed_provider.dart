import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:social_media/models/post_model.dart';

class FeedProvider extends ChangeNotifier {
    Stream<QuerySnapshot> postStream = FirebaseFirestore.instance
        .collection('posts')
        .orderBy('datePublished', descending: true)
        .snapshots();
}
