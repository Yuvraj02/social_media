class User {
  String? email;
  String uid;
  String userName;
  String? name;
  String? profilePhoto;
  bool isVerifiedEntity;
  List following;
  List followers;
  String nameSearchKey;
  String usernameSearchKey;

  User(
      {required this.userName,
        required this.nameSearchKey,
        required this.usernameSearchKey,
      required this.name,
      required this.uid,
      required this.email,
      this.isVerifiedEntity = false,
      required this.profilePhoto,
      required this.followers,
      required this.following});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "username": userName,
      "email": email,
      "uid": uid,
      "name": name,
      "profilePhoto": profilePhoto,
      "isVerifiedEntity": isVerifiedEntity,
      "followers": followers,
      "following": following,
      "searchKey" : nameSearchKey,
      "usernameSearchKey":usernameSearchKey,
    };
  }
}
