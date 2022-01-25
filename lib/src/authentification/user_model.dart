class UserModel {
  String uid;
  String name;
  String email;
  String tel;
  String? subname;
  String? token;
  String? photoUrl;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.tel,
    this.subname,
    this.token,
    this.photoUrl,
  });

  Map<String, dynamic> userToMap() {
    return {
      'name': name,
      'subname': subname,
      'email': email,
      'tel': tel,
      'photo_url': photoUrl,
    };
  }
}
