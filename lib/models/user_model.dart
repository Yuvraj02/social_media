import 'dart:convert';

class UserModel {
  String? email;
  String uid;
  String userName;
  String? name;
  String? profilePhoto;
  bool isVerified;
  bool isAnEntity;
  String nameSearchKey;
  String usernameSearchKey;

  //List<String>? skills;
  //List following;
  //List followers;

  UserModel({required this.userName,
    required this.nameSearchKey,
    required this.usernameSearchKey,
    required this.name,
    required this.uid,
    required this.email,
    required this.isVerified,
    required this.isAnEntity,
    required this.profilePhoto,
    //required this.followers,
    //required this.following,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "username": userName,
      "email": email,
      "uid": uid,
      "name": name,
      "profilePhoto": profilePhoto,
      "isVerified": isVerified,
      "isAnEntity":isAnEntity,
      "searchKey": nameSearchKey,
      "usernameSearchKey": usernameSearchKey,
      // "followers": followers,
      // "following": following,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      UserModel(userName: json['username'],
          nameSearchKey: json['searchKey'],
          usernameSearchKey: json['usernameSearchKey'],
          name: json['name'],
          uid: json['uid'],
          email: json['email'],
          profilePhoto: json['profilePhoto'],
          isAnEntity: json['isAnEntity'],
          isVerified: json['isVerified'],
        // followers: json['followers'],
        // following: json['following'],
      );

}
