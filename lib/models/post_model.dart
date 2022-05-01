import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  String? postUrl;
  String postID;
  String caption;
  String uid;
  String name;
  Timestamp date;
  bool fromVerified;

  PostModel(
      {this.postUrl,
      required this.postID,
      required this.caption,
      required this.uid,
      required this.name,
      required this.date,
      required this.fromVerified});

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
      fromVerified: json['fromVerified'],
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
      'fromVerified':fromVerified,
    };
  }
}
