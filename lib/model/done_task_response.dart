// @dart=2.9
import 'dart:convert';

DoneTaskResponse doneTaskResponseFromJson(String str) => DoneTaskResponse.fromJson(json.decode(str));

String doneTaskResponseToJson(DoneTaskResponse data) => json.encode(data.toJson());

class DoneTaskResponse {
  DoneTaskResponse({
    this.response,
  });

  ResponseData response;

  factory DoneTaskResponse.fromJson(Map<String, dynamic> json) => DoneTaskResponse(
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
    data: json["data"]!=null? List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))):[],
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
    this.eventId,
    this.toUser,
    this.toContact,
    this.fromUser,
    this.fromUserId,
    this.fromUserName,
    this.fromContact,
    this.eventName,
    this.priority,
    this.date,
    this.dateSend,
    this.dateAccept,
    this.dateReject,
    this.dateComplete,
    this.dateCancel,
    this.eventFrom,
    this.eventTo,
    this.eventStatus,
    this.latitude,
    this.longitude,
    this.radius,
    this.comingIn,
    this.fromDeviceToken,
    this.toDeviceToken,
    this.receiverProfilePic,
    this.receiverPpThumbnail,
    this.senderProfilePic,
    this.senderPpThumbnail,
    this.toUserId,
    this.isGroupchat,
    this.msgBadge,
    this.lastMsg,
    this.isSeen,
    this.groupName,
  });

  String userId;
  String eventId;
  String toUser;
  String toContact;
  String fromUser;
  String fromUserId;
  String fromUserName;
  String fromContact;
  String eventName;
  String priority;
  String date;
  String dateSend;
  String dateAccept;
  String dateReject;
  String dateComplete;
  String dateCancel;
  String eventFrom;
  String eventTo;
  String eventStatus;
  String latitude;
  String longitude;
  String radius;
  String comingIn;
  String fromDeviceToken;
  String toDeviceToken;
  String receiverProfilePic;
  String receiverPpThumbnail;
  String senderProfilePic;
  String senderPpThumbnail;
  String toUserId;
  String isGroupchat;
  String msgBadge;
  String lastMsg;
  String isSeen;
  String groupName;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    userId: json["user_id"],
    eventId: json["event_id"],
    toUser: json["to_user"],
    toContact: json["to_contact"],
    fromUser: json["from_user"],
    fromUserId: json["from_user_id"],
    fromUserName: json["from_user_name"],
    fromContact: json["from_contact"],
    eventName: json["event_name"],
    priority: json["priority"],
    date: json["date"],
    dateSend: json["date_send"],
    dateAccept: json["date_accept"],
    dateReject: json["date_reject"],
    dateComplete: json["date_complete"],
    dateCancel: json["date_cancel"],
    eventFrom: json["event_from"],
    eventTo: json["event_to"],
    eventStatus: json["event_status"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    radius: json["radius"],
    comingIn: json["coming_in"],
    fromDeviceToken: json["from_device_token"],
    toDeviceToken: json["to_device_token"],
    receiverProfilePic: json["receiver_profile_pic"],
    receiverPpThumbnail: json["receiver_ppThumbnail"],
    senderProfilePic: json["sender_profile_pic"],
    senderPpThumbnail: json["sender_ppThumbnail"],
    toUserId: json["to_user_id"],
    isGroupchat: json["is_groupchat"],
    msgBadge: json["msgBadge"],
    lastMsg: json["lastMsg"],
    isSeen: json["is_seen"],
    groupName: json["groupName"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "event_id": eventId,
    "to_user": toUser,
    "to_contact": toContact,
    "from_user": fromUser,
    "from_user_id": fromUserId,
    "from_user_name": fromUserName,
    "from_contact": fromContact,
    "event_name": eventName,
    "priority": priority,
    "date": date,
    "date_send": dateSend,
    "date_accept": dateAccept,
    "date_reject": dateReject,
    "date_complete": dateComplete,
    "date_cancel": dateCancel,
    "event_from": eventFrom,
    "event_to": eventTo,
    "event_status": eventStatus,
    "latitude": latitude,
    "longitude": longitude,
    "radius": radius,
    "coming_in": comingIn,
    "from_device_token": fromDeviceToken,
    "to_device_token": toDeviceToken,
    "receiver_profile_pic": receiverProfilePic,
    "receiver_ppThumbnail": receiverPpThumbnail,
    "sender_profile_pic": senderProfilePic,
    "sender_ppThumbnail": senderPpThumbnail,
    "to_user_id": toUserId,
    "is_groupchat": isGroupchat,
    "msgBadge": msgBadge,
    "lastMsg": lastMsg,
    "is_seen": isSeen,
    "groupName": groupName,
  };
}
