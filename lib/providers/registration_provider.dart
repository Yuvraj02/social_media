import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:social_media/models/user_model.dart';

import '../utilities/auth_helper.dart';

class RegistrationProvider extends ChangeNotifier {
  void registerStudent(
      {required String name,
      required String userName,
      required String email,
      required String password}) {
    var _firestore = FirebaseFirestore.instance;
    var uid;
    AuthHelper.registerUser(name, email, password)
        .then((value) {
          _firestore.collection('users').doc(value!.uid).set(UserModel(
                name: value.displayName,
                userName: userName,
                nameSearchKey: name[0].toUpperCase(),
                usernameSearchKey: userName[0],
                uid: value.uid,
                email: value.email,
                profilePhoto: value.photoURL,
                isAnEntity: false,
                isVerified: false,
              ).toJson());
          uid = value.uid;
        })
        .then((value) =>
            _firestore.collection('users/$uid/bookmark').add({'bookmark': 0}));
  }

  void registerEntity(String name, String email, String password) {
    var _firestore = FirebaseFirestore.instance;
    var uid;
    AuthHelper.registerUser(name, email, password).then((value) {
      _firestore
          .collection('users')
          .doc(value!.uid)
          .set(UserModel(
                  name: value.displayName,
                  nameSearchKey: name[0].toUpperCase(),
                  usernameSearchKey: name[0].toLowerCase(),
                  userName: "",
                  uid: value.uid,
                  email: value.email,
                  profilePhoto: value.photoURL,
                  isAnEntity: true,
                  isVerified: true,
                  // following: [],
                  // followers: [],
           )
              .toJson());
      uid = value.uid;
    }) .then((value) =>
        _firestore.collection('users/$uid/bookmark').add({'bookmark': 0}));
  }
}
