import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:social_media/models/user_model.dart';

import '../utilities/auth_helper.dart';

class RegistrationProvider extends ChangeNotifier {
  void registerStudent(String name, String email, String password) {
    var _firestore = FirebaseFirestore.instance;
    var uid;
    AuthHelper.registerUser(name, email, password).then((value) {
      _firestore.collection('users').doc(value!.uid).set(
          // {
          //   "email": value.email,
          //   "uid": value.uid,
          //   "name": value.displayName,
          //   "profilePhoto":value.photoURL,
          //   "isVerifiedEntity":false
          // },
          User(
                  name: value.displayName,
                  uid: value.uid,
                  email: value.email,
                  profilePhoto: value.photoURL,
                  following: [],
                  followers: [])
              .toJson());
      uid = value.uid;
    }).then((value) =>
        _firestore.collection('users/$uid/bookmark').add({'bookmark': 0}));

    // .then((value) =>
    // _firestore
    //     .collection('users/$uid/posts')
    //     .add({"postNum": 0}))
    // .then((value) =>
    // _firestore
    //     .collection('users/$uid/stories')
    //     .add({'story': 0}))
  }

  void registerEntity(String name, String email, String password) {
    var _firestore = FirebaseFirestore.instance;
    AuthHelper.registerUser(name, email, password).then((value) {
      _firestore.collection('entities/entities_list/names').doc(value!.uid).set(
          User(
                  name: value.displayName,
                  uid: value.uid,
                  email: value.email,
                  profilePhoto: value.photoURL,
                  following: [],
                  followers: [],
                  isVerifiedEntity: true)
              .toJson());
    });
  }
}
