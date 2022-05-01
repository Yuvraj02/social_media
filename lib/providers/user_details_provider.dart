import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';


class UserDetailsProvider extends ChangeNotifier {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool? following;

  //User? user;
  List followingUids = [];

  getData(String uid) {
    return _firestore
        .collection('posts')
        .where('uid', isEqualTo: uid)
        .snapshots();
  }

  Stream<DocumentSnapshot<Object?>> userProfile(String uid) {
    Stream<DocumentSnapshot<Object?>> userStream =
        FirebaseFirestore.instance.collection('users').doc(uid).snapshots();
    return userStream;
  }

}
