import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_media/screens/home_screen.dart';
import 'package:social_media/screens/login_screen.dart';

//bool isLateUser=false;
bool newUser = false;

class AuthHelper {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static get user => _auth.currentUser;
  static bool justRegisterd = false;

  static Future<User?> registerUser(
      String name, String email, String password) async {
    // FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      user = userCredential.user;
      await user!.updateDisplayName(name);
      await user.reload();
      user = _auth.currentUser;
      justRegisterd = true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak');
      } else if (e.code == 'email-already-in-use') {
        print('The Account already exists');
      }
    } catch (error) {
      print(error);
    }
    return user;
  }

  static Future<User?> logInUser(String email, String password) async {
    //FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    DateTime? creationTime;
    DateTime? lastSignIn;
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      //isLateUser = await userCredential.additionalUserInfo!.isNewUser;
      user = userCredential.user;
      creationTime = user?.metadata.creationTime;
      lastSignIn = user?.metadata.lastSignInTime;
      var difference = lastSignIn?.difference(creationTime!).inMinutes;
      print(difference);
      if (difference! < 1) {
        newUser = true;
      }
      print(newUser);
    } on FirebaseAuthException catch (error) {
      if (error.code == 'user-not-found') {
        print("User does not exist");
      } else if (error.code == 'wrong-password') {
        print('Incorrect password');
      }
    }
    return user;
  }

  static signOut() => _auth.signOut();

  static Stream<User?> get onAuthStateChanged => _auth.authStateChanges();
}