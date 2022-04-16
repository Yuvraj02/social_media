import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  String postUrl;
  String postID;
  String caption;
  String uid;
  String name;
  Timestamp date;

  Post(
      {required this.postUrl,
      required this.postID,
      required this.caption,
      required this.uid,
      required this.name,
      required this.date});

  factory Post.fromJson(Map<String, dynamic> json) => Post(
      postUrl: json['postUrl'],
      postID: json['postID'],
      caption: json['caption'],
      uid: json['uid'],
      name: json['name'],
      date:json['datePublished']);


  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'postUrl': postUrl,
      'postID': postID,
      'caption': caption,
      'uid': uid,
      'name': name,
      'datePublished' : date,
    };
  }
}
