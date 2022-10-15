class ChatModelMini {
  String sender;
  String text;
  bool isMe;
  int timeStamp;

  ChatModelMini(
      {required this.sender,
      required this.text,
      required this.isMe,
      required this.timeStamp});

  Map toJson() =>
      {"sender": sender, "text": text, "isMe": isMe, "timeStamp": timeStamp};

  static ChatModelMini fromMap(Map<String, dynamic> json) => ChatModelMini(
      sender: json["sender"],
      text: json["text"],
      isMe: json["isMe"],
      timeStamp: json["timeStamp"]);
}

class ChatModelMinix {
  String sender;
  String text;
  bool isMe;
  int timeStamp;

  ChatModelMinix(
      {required this.sender,
      required this.text,
      required this.isMe,
      required this.timeStamp});
}
