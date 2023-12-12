// @dart=2.9
import 'dart:convert';

SendMessage sendMessageFromJson(String str) => SendMessage.fromJson(json.decode(str));

String sendMessageToJson(SendMessage data) => json.encode(data.toJson());

class SendMessage {
  SendMessage({
    this.userId,
    this.username,
    this.message,
    this.msgType,
    this.isCenter,
    this.msgColor,
    this.toUserId,
    this.contact,
    this.chatType,
    this.isSeen,
    this.groupId,
    this.thumbnail,
    this.profilePic,
    this.datetime,
    this.otherUserId,
    this.otherUserContact,
    this.otherUserName,
  });

  String userId;
  String username;
  String message;
  String msgType;
  bool isCenter;
  String msgColor;
  String toUserId;
  String contact;
  String chatType;
  String isSeen;
  String groupId;
  String thumbnail;
  String profilePic;
  int datetime;
  String otherUserId;
  String otherUserContact;
  String otherUserName;

  factory SendMessage.fromJson(Map<String, dynamic> json) => SendMessage(
    userId: json["user_id"],
    username: json["username"],
    message: json["message"],
    msgType: json["msg_type"],
    isCenter: json["is_center"],
    msgColor: json["msg_color"],
    toUserId: json["to_user_id"],
    contact: json["contact"],
    chatType: json["chat_type"],
    isSeen: json["is_seen"],
    groupId: json["group_id"],
    thumbnail: json["thumbnail"],
    profilePic: json["profile_pic"],
    datetime: json["datetime"],
    otherUserId: json["otherUserId"],
    otherUserContact: json["otherUserContact"],
    otherUserName: json["otherUserName"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "username": username,
    "message": message,
    "msg_type": msgType,
    "is_center": isCenter,
    "msg_color": msgColor,
    "to_user_id": toUserId,
    "contact": contact,
    "chat_type": chatType,
    "is_seen": isSeen,
    "group_id": groupId,
    "thumbnail": thumbnail,
    "profile_pic": profilePic,
    "datetime": datetime,
    "otherUserId": otherUserId,
    "otherUserContact": otherUserContact,
    "otherUserName": otherUserName,
  };
}
