import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media/models/event_model.dart';
import 'package:uuid/uuid.dart';
import '../screens/eventScreens/announcements_screen.dart';
import '../screens/eventScreens/create_event_screen.dart';
import '../utilities/auth_helper.dart';

class EventsProvider extends ChangeNotifier {
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

  Future<String> createEvent(
      {Uint8List? file,
      required String description,
      required String title}) async {
    String res = "Some Error Occured";
    String? postUrl;
    if (file != null) {
      postUrl = await _uploadToFirebaseStorage('events', file, true);
    }
    try {
      String? name = _firebaseAuth.currentUser!.displayName;
      String postId = const Uuid().v1();
      EventModel event = EventModel(
        title: title,
        description: description,
        uid: _firebaseAuth.currentUser!.uid,
        datePublished: Timestamp.now(),
        eventAuthorName: name!,
        eventDate: "Today at 6 PM",
        imageUrl: postUrl,
      );
      _firestore.collection('events').doc(postId).set(event.toJson());
      _firestore
          .collection('users/${_firebaseAuth.currentUser!.uid}/events')
          .doc(postId)
          .set(event.toJson());

      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Stream<QuerySnapshot> eventStream = FirebaseFirestore.instance
      .collection('events')
      .orderBy('datePublished', descending: true)
      .snapshots();

  //---------------------------Custom Dialogue Box---------------------------------

  dialogBox(BuildContext context) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Container(
              height: 180,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: isVerified == null
                    ? Center(child: CircularProgressIndicator())
                    : isVerified == false
                        ? Text("Contact Us")
                        : Column(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => CreateEvent()));
                                  },
                                  child: Row(
                                    // mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.event),
                                      SizedBox(
                                        width: 6,
                                      ),
                                      Text(
                                        "Create an Event",
                                        style: TextStyle(fontSize: 22),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Divider(
                                thickness: 1,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                CreateAnnouncement()));
                                  },
                                  child: Row(
                                    // mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.mic_external_on),
                                      SizedBox(
                                        width: 6,
                                      ),
                                      Text(
                                        "Create an Announcement",
                                        style: TextStyle(fontSize: 22),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Divider(
                                thickness: 1,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.cancel,
                                        color: Colors.red,
                                      ),
                                      SizedBox(
                                        width: 6,
                                      ),
                                      Text(
                                        "Cancel",
                                        style: TextStyle(
                                            color: Colors.red, fontSize: 22),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
              ),
            ),
          );
        });
  }
}
