import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

bool newUser = false;

class AuthHelper {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static get user => _auth.currentUser;
  static bool justRegisterd = false;
  static String? UID;
  static bool? isVerifiedEntity;

  static entityCheck() async {
    UID = await AuthHelper.getCurrentUID();
    var snapshot = await _firestore.collection('users').doc(UID).get();
      if(snapshot.exists){
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        isVerifiedEntity = data['isVerified'];
      }
  }

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
      user = userCredential.user;
      creationTime = user?.metadata.creationTime;
      lastSignIn = user?.metadata.lastSignInTime;
      var difference = lastSignIn?.difference(creationTime!).inMinutes;
    //  print(difference);
      if (difference! < 1) {
        newUser = true;
      }
    //  print(newUser);
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

  static Future<String> getCurrentUID() async {
    return _auth.currentUser!.uid;
  }

}
