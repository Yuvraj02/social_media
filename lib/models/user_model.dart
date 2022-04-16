class User {
  String? email;
  String uid;
  String? name;
  String? profilePhoto;
  bool isVerifiedEntity;
  List following;
  List followers;

  User(
      {required this.name,
      required this.uid,
      required this.email,
      this.isVerifiedEntity = false,
      required this.profilePhoto,
      required this.followers,
      required this.following});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "email": email,
      "uid": uid,
      "name": name,
      "profilePhoto": profilePhoto,
      "isVerifiedEntity": isVerifiedEntity,
    };
  }
}
