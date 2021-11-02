class MessageModel {
  late String receiverId;
  late String text;
  late String dateTime;
  late String senderId;

  MessageModel({
    required this.text,
    required this.receiverId,
    required this.senderId,
    required this.dateTime,
  });

  MessageModel.fromJson(Map<String, dynamic>? json) {
    text = json!['text'] as String;
    receiverId = json['receiverId'] as String;
    senderId = json['senderId'] as String;
    dateTime = json['dateTime'] as String;

  }
  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'receiverId': receiverId,
      'senderId': senderId,
      'dateTime': dateTime
    };
  }
}
