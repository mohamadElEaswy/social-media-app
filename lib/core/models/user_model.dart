class UserModel {
  String? name;
  String? phone;
  String? email;
  String? uId;

  UserModel(
      {required this.name,
      required this.email,
      required this.phone,
      required this.uId});

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'] as String;
    phone = json['phone'] as String;
    email = json['email'] as String;
    uId = json['email'] as String;
  }
  Map<String, dynamic> toMap() {
    return {'name': name, 'phone': phone, 'email': email, 'uId': uId};
  }
}
