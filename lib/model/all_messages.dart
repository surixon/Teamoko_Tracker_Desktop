// @dart=2.9
import 'dart:convert';

AllMessages allMessagesFromJson(String str) => AllMessages.fromJson(json.decode(str));

String allMessagesToJson(AllMessages data) => json.encode(data.toJson());

class AllMessages {
  AllMessages({
    this.currentPage,
    this.pageSize,
    this.totalRecords,
    this.lastPage,
    this.output,
  });

  String currentPage='1';
  String pageSize;
  int totalRecords;
  int lastPage;
  List<Output> output;

  factory AllMessages.fromJson(Map<String, dynamic> json) => AllMessages(
    currentPage: json["current_page"],
    pageSize: json["page_size"],
    totalRecords: json["total_records"],
    lastPage: json["last_page"],
    output: List<Output>.from(json["output"].map((x) => Output.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "page_size": pageSize,
    "total_records": totalRecords,
    "last_page": lastPage,
    "output": List<dynamic>.from(output.map((x) => x.toJson())),
  };
}

class Output {
  Output({
    this.id,
    this.userId,
    this.username,
    this.contact,
    this.groupId,
    this.chatType,
    this.message,
    this.msgType,
    this.images,
    this.isDownload,
    this.datetime,
    this.isCenter,
    this.msgColor,
    this.isSeen,
    this.imageName,
    this.thumbnail,
    this.duration,
    this.otherUserId,
    this.otherUserContact,
    this.otherUserName,
  });

  String id;
  String userId;
  String username;
  String contact;
  String groupId;
  String chatType;
  String message;
  String msgType;
  String images;
  String isDownload;
  int datetime;
  String isCenter;
  String msgColor;
  String isSeen;
  String imageName;
  String thumbnail;
  String duration;
  String otherUserId;
  String otherUserContact;
  String otherUserName;

  factory Output.fromJson(Map<String, dynamic> json) => Output(
    id: json["id"],
    userId: json["user_id"],
    username: json["username"],
    contact: json["contact"],
    groupId: json["group_id"],
    chatType: json["chat_type"],
    message: json["message"],
    msgType: json["msg_type"],
    images: json["images"],
    isDownload: json["is_download"],
    datetime: json["datetime"],
    isCenter: json["is_center"],
    msgColor: json["msg_color"],
    isSeen: json["is_seen"],
    imageName: json["imageName"],
    thumbnail: json["thumbnail"],
    duration: json["duration"],
    otherUserId: json["otherUserId"],
    otherUserContact: json["otherUserContact"],
    otherUserName: json["otherUserName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "username": username,
    "contact": contact,
    "group_id": groupId,
    "chat_type": chatType,
    "message": message,
    "msg_type": msgType,
    "images": images,
    "is_download": isDownload,
    "datetime": datetime,
    "is_center": isCenter,
    "msg_color": msgColor,
    "is_seen": isSeen,
    "imageName": imageName,
    "thumbnail": thumbnail,
    "duration": duration,
    "otherUserId": otherUserId,
    "otherUserContact": otherUserContact,
    "otherUserName": otherUserName,
  };
}
