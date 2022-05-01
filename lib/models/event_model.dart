import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {
  String title;
  String description;
  String eventAuthorName;
  String eventDate;
  Timestamp datePublished;
  String? imageUrl;

  EventModel(
      {required this.title,
      required this.description,
      required this.eventAuthorName,
      required this.eventDate,
      required this.imageUrl,
      required this.datePublished});

  factory EventModel.fromJson(Map<String, dynamic> json) => EventModel(
      title: json['title'],
      description: json['description'],
      eventAuthorName: json['eventAuthorName'],
      eventDate: json['eventData'],
      imageUrl: json['imageUrl'],
      datePublished: json['datePublished']);

  Map<String,dynamic> toJson(){
    return <String,dynamic>{
      'title':title,
      'description':description,
      'eventAuthorName':eventAuthorName,
      'eventDate':eventDate,
      'datePublished':datePublished,
      'imageUrl':imageUrl,
    };
  }

}
