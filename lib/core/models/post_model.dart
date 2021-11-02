class PostModel {
  late String name;
  late String postImage;
  late String image;
  late String text;
  late String? uId;
  late String? dateTime;

  PostModel({
    required this.name,
    required this.uId,
    required this.image,
    required this.text,
    required this.dateTime,
    this.postImage = '',
  });

  PostModel.fromJson(Map<String, dynamic>? json) {
    name = json!['name'] as String;
    text = json['text'] as String;
    image = json['image'] as String;
    dateTime = json['dateTime'] as String;
    uId = json['uId'] as String;
    postImage = json['postImage'] as String;
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'text': text,
      'image': image,
      'uId': uId,
      'postImage': postImage,
      'dateTime': dateTime
    };
  }
}
