import 'dart:convert';

class User {
  String? email;
  String uid;
  String userName;
  String? name;
  String? profilePhoto;
  bool isVerifiedEntity;
  // List following;
  // List followers;
  String nameSearchKey;
  String usernameSearchKey;
  //List<String>? skills;

  User({required this.userName,
    required this.nameSearchKey,
    required this.usernameSearchKey,
    required this.name,
    required this.uid,
    required this.email,
    this.isVerifiedEntity = false,
    required this.profilePhoto,
  //  required this.followers,
    //required this.following,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "username": userName,
      "email": email,
      "uid": uid,
      "name": name,
      "profilePhoto": profilePhoto,
      "isVerifiedEntity": isVerifiedEntity,
      // "followers": followers,
      // "following": following,
      "searchKey": nameSearchKey,
      "usernameSearchKey": usernameSearchKey,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) =>
      User(userName: json['username'],
          nameSearchKey: json['searchKey'],
          usernameSearchKey: json['usernameSearchKey'],
          name: json['name'],
          uid: json['uid'],
          email: json['email'],
          profilePhoto: json['profilePhoto'],
          // followers: json['followers'],
          // following: json['following'],
          isVerifiedEntity: json['isVerifiedEntity']);

}
