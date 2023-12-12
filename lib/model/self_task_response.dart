// @dart=2.9
import 'dart:convert';

SelfTaskResponse selfTaskResponseFromJson(String str) => SelfTaskResponse.fromJson(json.decode(str));

String selfTaskResponseToJson(SelfTaskResponse data) => json.encode(data.toJson());

class SelfTaskResponse {
  SelfTaskResponse({
    this.response,
  });

  ResponseData response;

  factory SelfTaskResponse.fromJson(Map<String, dynamic> json) => SelfTaskResponse(
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
  List<SelfDatum> data;

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
    data: json["data"]!=null?List<SelfDatum>.from(json["data"].map((x) => SelfDatum.fromJson(x))):[],
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

class SelfDatum {
  SelfDatum({
    this.userId,
    this.profilePic,
    this.ppThumbnail,
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
    this.playPause,
    this.eventFrom,
    this.eventTo,
    this.eventStatus,
    this.latitude,
    this.longitude,
    this.radius,
    this.comingIn,
    this.isPresentInSearchField,
  });

  String userId;
  String profilePic;
  String ppThumbnail;
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
  String playPause;
  String eventFrom;
  String eventTo;
  String eventStatus;
  String latitude;
  String longitude;
  String radius;
  String comingIn;
  bool isPresentInSearchField;

  factory SelfDatum.fromJson(Map<String, dynamic> json) => SelfDatum(
    userId: json["user_id"],
    profilePic: json["profile_pic"],
    ppThumbnail: json["ppThumbnail"],
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
    playPause: json["play_pause"],
    eventFrom: json["event_from"],
    eventTo: json["event_to"],
    eventStatus: json["event_status"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    radius: json["radius"],
    comingIn: json["coming_in"],
    isPresentInSearchField: json["isPresentInSearchField"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "profile_pic": profilePic,
    "ppThumbnail": ppThumbnail,
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
    "play_pause": playPause,
    "event_from": eventFrom,
    "event_to": eventTo,
    "event_status": eventStatus,
    "latitude": latitude,
    "longitude": longitude,
    "radius": radius,
    "coming_in": comingIn,
    "isPresentInSearchField": isPresentInSearchField,
  };
}
