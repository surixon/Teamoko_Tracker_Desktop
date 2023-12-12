// @dart=2.9
import 'dart:convert';

TypingData typingDataFromJson(String str) => TypingData.fromJson(json.decode(str));

String typingDataToJson(TypingData data) => json.encode(data.toJson());

class TypingData {
  TypingData({
    this.username,
    this.groupId,
    this.isTyping,
    this.chatType,
  });

  String username;
  String groupId;
  String isTyping;
  String chatType;

  factory TypingData.fromJson(Map<String, dynamic> json) => TypingData(
    username: json["username"],
    groupId: json["group_id"],
    isTyping: json["isTyping"],
    chatType: json["chat_type"],
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "group_id": groupId,
    "isTyping": isTyping,
    "chat_type": chatType,
  };
}