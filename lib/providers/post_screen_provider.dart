import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media/models/post_model.dart';
import 'package:social_media/utilities/auth_helper.dart';
import 'package:uuid/uuid.dart';

class PostProvider with ChangeNotifier {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool? isVerified;

  entityCheck() async {
    String UID = await AuthHelper.getCurrentUID();

    var snapshot = await _firestore.collection('users').doc(UID).get();
    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      isVerified = data['isVerified'];
    }
    notifyListeners();
  }

  //-----------To pick the media
  pickImage(ImageSource source) async {
    final ImagePicker _imagePicker = ImagePicker();
    XFile? _file =
        await _imagePicker.pickImage(source: source, imageQuality: 20);

    if (_file != null) {
      File actualFile = File(_file.path);
      File? croppedFile = await cropImage(actualFile);
      if (croppedFile != null) {
        return croppedFile.readAsBytes();
      } else {
        print("Another File is null");
      }
    }
    print('No Image Selected');
  }

  Future<File?> cropImage(File file) async {
    return await ImageCropper().cropImage(
        sourcePath: file.path,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        aspectRatioPresets: [CropAspectRatioPreset.square]);
  }

  Future<String> _uploadToFirebaseStorage(
      String childName, Uint8List file, bool isPost) async {
    Reference ref =
        _storage.ref().child(childName).child(_firebaseAuth.currentUser!.uid);

    if (isPost) {
      String id = const Uuid().v1();
      ref = ref.child(id);
    }

    UploadTask uploadTask = ref.putData(file);

    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();

    return downloadUrl;
  }

  Future<String> uploadVerifiedPost(
      {Uint8List? file, required String caption}) async {
    String res = "Some Error Occured";
    String? postUrl;
    if (file != null) {
      postUrl = await _uploadToFirebaseStorage('posts', file, true);
    }
    try {
      String? name = _firebaseAuth.currentUser!.displayName;
      String postId = const Uuid().v1();
      PostModel post = PostModel(
          postUrl: postUrl,
          postID: postId,
          caption: caption,
          uid: _firebaseAuth.currentUser!.uid,
          name: name!,
          date: Timestamp.now(),
          fromVerified: true);

      _firestore.collection('posts').doc(postId).set(post.toJson());
      _firestore
          .collection('users/${_firebaseAuth.currentUser!.uid}/posts')
          .doc(postId)
          .set(post.toJson());

      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> uploadStudentPost(
      {Uint8List? file, required String caption}) async {
    String res = "Some Error Occured";
    String? postUrl;
    if (file != null) {
      postUrl = await _uploadToFirebaseStorage('posts', file, true);
    }
    try {
      String? name = _firebaseAuth.currentUser!.displayName;
      String postId = const Uuid().v1();
      PostModel post = PostModel(
          postUrl: postUrl,
          postID: postId,
          caption: caption,
          uid: _firebaseAuth.currentUser!.uid,
          name: name!,
          date: Timestamp.now(),
          fromVerified: false);

      _firestore.collection('student_posts').doc(postId).set(post.toJson());
      _firestore
          .collection('users/${_firebaseAuth.currentUser!.uid}/posts')
          .doc(postId)
          .set(post.toJson());
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
