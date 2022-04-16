import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media/models/post_model.dart';
import 'package:social_media/utilities/auth_helper.dart';
import 'package:uuid/uuid.dart';

class PostProvider with ChangeNotifier {
  var firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool? isEntity;

  //------Check if the user is a verified entity or not
  entityCheck() async {
    String UID = await AuthHelper.getCurrentUID();
    var collection = firestore.collection('/entities/entities_list/names');
    var docSnapshot = await collection.doc(UID).get();
    if (docSnapshot.exists) {
      isEntity = true;
    } else {
      isEntity = false;
    }
    notifyListeners();
  }

  pickImage(ImageSource source) async {
    final ImagePicker _imagePicker = ImagePicker();
    XFile? _file = await _imagePicker.pickImage(source: source);
    if (_file != null) {
      return await _file.readAsBytes();
    }
    print('No Image Selected');
  }

  Future<String> _uploadToFirebaseStorage(
      String childName, Uint8List file, bool isPost) async {
    Reference ref = _storage.ref().child(childName).child(_firebaseAuth.currentUser!.uid);

    if(isPost){
      String id = const Uuid().v1();
      ref = ref.child(id);
    }

    UploadTask uploadTask = ref.putData(file);

    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();

    return downloadUrl;
  }

  Future<String> uploadPost({required Uint8List file,required String caption}) async {
    String res = "Some Error Occured";
    try {
      String postUrl = await _uploadToFirebaseStorage('posts', file, true);
      String? name = _firebaseAuth.currentUser!.displayName;
      String postId = const Uuid().v1();
      Post post = Post(
          postUrl: postUrl,
          postID: postId,
          caption: caption,
          uid: _firebaseAuth.currentUser!.uid,
          name: name!,
          date: Timestamp.now());

      _firestore.collection('posts').doc(postId).set(post.toJson());
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
