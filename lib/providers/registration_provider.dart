import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../utilities/auth_helper.dart';

class RegistrationProvider extends ChangeNotifier{

  bool justRegistered = false;

  void registerUser(String name,String email, String password) {
    var _firestore = FirebaseFirestore.instance;
    var uid;
    AuthHelper.registerUser(name,
        email, password)
        .then((value) {
      _firestore.collection('users').doc(value!.uid).set(
        {
          "email": value.email,
          "uid": value.uid,
          "name": value.displayName,
          "profilePhoto":value.photoURL,
        },
      );
      uid = value.uid;
    })
        .then((value) =>
        _firestore
            .collection('users/$uid/posts')
            .add({"postNum": 0}))
        .then((value) =>
        _firestore
            .collection('users/$uid/stories')
            .add({'story': 0}))
        .then((value) =>
        _firestore
            .collection('users/$uid/bookmark')
            .add({'bookmark': 0}));
    justRegistered = true;
    notifyListeners();
  }
}