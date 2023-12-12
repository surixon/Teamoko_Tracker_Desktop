// @dart=2.9
import 'dart:convert';
TasksListResponse tasksResponseFromJson(String str) => TasksListResponse.fromJson(json.decode(str));

String tasksResponseToJson(TasksListResponse data) => json.encode(data.toJson());

class TasksListResponse {
  TasksListResponse({
    this.response,
  });

  ResponseData response;

  factory TasksListResponse.fromJson(Map<String, dynamic> json) => TasksListResponse(
    response: ResponseData.fromJson(json["response"]),
  );

  Map<String, dynamic> toJson() => {
    "response": response.toJson(),
  };
}

class ResponseData {
  ResponseData({
    this.message,
    this.status,
    this.currentPage,
    this.pageSize,
    this.totalRecords,
    this.lastPage,
    this.selfTask,
    this.totalTask,
    this.done,
    this.totalMembers,
    this.data,
  });

  String message;
  String status;
  String currentPage;
  String pageSize;
  String totalRecords;
  String lastPage;
  String selfTask;
  String totalTask;
  String done;
  String totalMembers;
  List<Datum> data;

  factory ResponseData.fromJson(Map<String, dynamic> json) => ResponseData(
    message: json["message"],
    status: json["status"],
    currentPage: json["current_page"],
    pageSize: json["page_size"],
    totalRecords: json["total_records"],
    lastPage: json["last_page"],
    selfTask: json["selfTask"],
    totalTask: json["totalTask"],
    done: json["done"],
    totalMembers: json["total_members"],
    data: json["data"]!=null?List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))):[],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "current_page": currentPage,
    "page_size": pageSize,
    "total_records": totalRecords,
    "last_page": lastPage,
    "selfTask": selfTask,
    "totalTask": totalTask,
    "done": done,
    "total_members": totalMembers,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.userId,
    this.fromContact,
    this.userName,
    this.eventId,
    this.toUser,
    this.toContact,
    this.fromUser,
    this.eventName,
    this.fromUserName,
    this.priority,
    this.date,
    this.dateSend,
    this.dateAccept,
    this.dateReject,
    this.dateComplete,
    this.dateReopen,
    this.playPause,
    this.eventFrom,
    this.eventTo,
    this.eventStatus,
    this.latitude,
    this.longitude,
    this.radius,
    this.comingIn,
    this.companyId,
    this.bage,
    this.badgeId,
    this.fromDeviceToken,
    this.toDeviceToken,
    this.receiverProfilePic,
    this.receiverPpThumbnail,
    this.senderPpThumbnail,
    this.senderProfilePic,
    this.isGroupchat,
    this.msgBadge,
    this.lastMsg,
    this.isSeen,
    this.groupName,
  });

  String userId;
  String fromContact;
  String userName;
  String eventId;
  String toUser;
  String toContact;
  String fromUser;
  String eventName;
  String fromUserName;
  String priority;
  String date;
  String dateSend;
  String dateAccept;
  String dateReject;
  String dateComplete;
  String dateReopen;
  String playPause;
  String eventFrom;
  String eventTo;
  String eventStatus;
  String latitude;
  String longitude;
  String radius;
  String comingIn;
  String companyId;
  String bage;
  String badgeId;
  String fromDeviceToken;
  String toDeviceToken;
  String receiverProfilePic;
  String receiverPpThumbnail;
  String senderPpThumbnail;
  String senderProfilePic;
  String isGroupchat;
  String msgBadge;
  String lastMsg;
  String isSeen;
  String groupName;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    userId: json["user_id"],
    fromContact: json["from_contact"],
    userName: json["user_name"],
    eventId: json["event_id"],
    toUser: json["to_user"],
    toContact: json["to_contact"],
    fromUser: json["from_user"],
    eventName: json["event_name"],
    fromUserName: json["from_user_name"],
    priority: json["priority"],
    date: json["date"],
    dateSend: json["date_send"],
    dateAccept: json["date_accept"],
    dateReject: json["date_reject"],
    dateComplete: json["date_complete"],
    dateReopen: json["date_reopen"],
    playPause: json["play_pause"],
    eventFrom: json["event_from"],
    eventTo: json["event_to"],
    eventStatus: json["event_status"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    radius: json["radius"],
    comingIn: json["coming_in"],
    companyId: json["company_id"],
    bage: json["bage"],
    badgeId: json["badge_id"],
    fromDeviceToken: json["from_device_token"],
    toDeviceToken: json["to_device_token"],
    receiverProfilePic: json["receiver_profile_pic"],
    receiverPpThumbnail: json["receiver_ppThumbnail"],
    senderPpThumbnail: json["sender_ppThumbnail"],
    senderProfilePic: json["sender_profile_pic"],
    isGroupchat: json["is_groupchat"],
    msgBadge: json["msgBadge"],
    lastMsg: json["lastMsg"],
    isSeen: json["is_seen"],
    groupName: json["groupName"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "from_contact": fromContact,
    "user_name": userName,
    "event_id": eventId,
    "to_user": toUser,
    "to_contact": toContact,
    "from_user": fromUser,
    "event_name": eventName,
    "from_user_name": fromUserName,
    "priority": priority,
    "date": date,
    "date_send": dateSend,
    "date_accept": dateAccept,
    "date_reject": dateReject,
    "date_complete": dateComplete,
    "date_reopen": dateReopen,
    "play_pause": playPause,
    "event_from": eventFrom,
    "event_to": eventTo,
    "event_status": eventStatus,
    "latitude": latitude,
    "longitude": longitude,
    "radius": radius,
    "coming_in": comingIn,
    "company_id": companyId,
    "bage": bage,
    "badge_id": badgeId,
    "from_device_token": fromDeviceToken,
    "to_device_token": toDeviceToken,
    "receiver_profile_pic": receiverProfilePic,
    "receiver_ppThumbnail": receiverPpThumbnail,
    "sender_ppThumbnail": senderPpThumbnail,
    "sender_profile_pic": senderProfilePic,
    "is_groupchat": isGroupchat,
    "msgBadge": msgBadge,
    "lastMsg": lastMsg,
    "is_seen": isSeen,
    "groupName": groupName,
  };
}