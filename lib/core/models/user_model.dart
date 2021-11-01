class UserModel {
  late String name;
  late String phone;
  late String email;
  late String image;
  late String cover;
  late String bio;
  late String? uId;

  UserModel(
      {required this.name,
      required this.email,
      required this.phone,
      this.image = '',
      this.cover = '',
      this.bio = '',
        this.uId});

  UserModel.fromJson(Map<String, dynamic>? json) {
    name = json!['name'] as String;
    phone = json['phone'] as String;
    email = json['email'] as String;
    uId = json['email'] as String;
    image = json['image'] as String;
    cover = json['cover'] as String;
    bio = json['bio'] as String;
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'email': email,
      'uId': uId,
      'image': image,
      'cover': cover,
      'bio': bio
    };
  }
}
