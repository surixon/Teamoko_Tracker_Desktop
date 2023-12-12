// @dart=2.9
import 'dart:convert';

Message messageFromJson(String str) => Message.fromJson(json.decode(str));

String messageToJson(Message data) => json.encode(data.toJson());

class Message {
  Message({
    this.id,
    this.userId,
    this.contact,
    this.username,
    this.message,
    this.msgType,
    this.chatType,
    this.groupId,
    this.images,
    this.datetime,
    this.isCenter,
    this.msgColor,
    this.isSeen,
    this.isDownload,
    this.toUserId,
    this.msgBadge,
    this.lastMsg,
    this.thumbnail,
    this.imageName,
    this.otherUserId,
    this.otherUserContact,
    this.otherUserName,
  });

  int id;
  String userId;
  String contact;
  String username;
  String message;
  String msgType;
  String chatType;
  String groupId;
  String images;
  int datetime;
  bool isCenter;
  String msgColor;
  String isSeen;
  String isDownload;
  List<String> toUserId;
  int msgBadge;
  String lastMsg;
  String thumbnail;
  String imageName;
  String otherUserId;
  String otherUserContact;
  String otherUserName;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    id: json["id"],
    userId: json["user_id"],
    contact: json["contact"],
    username: json["username"],
    message: json["message"],
    msgType: json["msg_type"],
    chatType: json["chat_type"],
    groupId: json["group_id"],
    images: json["images"],
    datetime: json["datetime"],
    isCenter: json["is_center"],
    msgColor: json["msg_color"],
    isSeen: json["is_seen"],
    isDownload: json["is_download"],
    toUserId: List<String>.from(json["toUserId"].map((x) => x)),
    msgBadge: json["msgBadge"],
    lastMsg: json["lastMsg"],
    thumbnail: json["thumbnail"],
    imageName: json["imageName"],
    otherUserId: json["otherUserId"],
    otherUserContact: json["otherUserContact"],
    otherUserName: json["otherUserName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "contact": contact,
    "username": username,
    "message": message,
    "msg_type": msgType,
    "chat_type": chatType,
    "group_id": groupId,
    "datetime": datetime,
    "is_center": isCenter,
    "msg_color": msgColor,
    "is_seen": isSeen,
    "images": images,
    "is_download": isDownload,
    "toUserId": List<dynamic>.from(toUserId.map((x) => x)),
    "msgBadge": msgBadge,
    "lastMsg": lastMsg,
    "thumbnail": thumbnail,
    "imageName": imageName,
    "imageName": imageName,
    "otherUserId": otherUserId,
    "otherUserContact": otherUserContact,
    "otherUserName": otherUserName,
  };
}
