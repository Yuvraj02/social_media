import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:social_media/models/user_model.dart';
import 'package:social_media/utilities/auth_helper.dart';

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

  Future<void> follow(User user) async {
    String currentUid = await AuthHelper.getCurrentUID();
    await _firestore.collection('users/$currentUid/following').doc(user.uid).set(
        user.toJson());
    print("Done");
  }

  Future<void> unFollow(User user)async{
    String currentUid = await AuthHelper.getCurrentUID();
    await _firestore.collection('users/$currentUid/following').doc(user.uid).delete();
  }

  Stream<DocumentSnapshot<Object?>> userProfile(String uid) {
    Stream<DocumentSnapshot<Object?>> userStream =
    FirebaseFirestore.instance.collection('users').doc(uid).snapshots();
    return userStream;
  }

  Stream<DocumentSnapshot<Object?>> followCheck(String searchUID) {
    // String currentUid = await AuthHelper.getCurrentUID();
    return _firestore.collection('users/${AuthHelper.UID}/following')
        .doc(searchUID)
        .snapshots();
  }

}
