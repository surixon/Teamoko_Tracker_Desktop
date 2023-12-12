// @dart=2.9
import 'dart:convert';
TaskDetailResponse taskDetailResponseFromJson(String str) => TaskDetailResponse.fromJson(json.decode(str));

String taskDetailResponseToJson(TaskDetailResponse data) => json.encode(data.toJson());

class TaskDetailResponse {
  TaskDetailResponse({
    this.response,
  });

  ResponseData response;

  factory TaskDetailResponse.fromJson(Map<String, dynamic> json) => TaskDetailResponse(
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
    this.data,
  });

  String message;
  String status;
  List<TaskDetailData> data;

  factory ResponseData.fromJson(Map<String, dynamic> json) => ResponseData(
    message: json["message"],
    status: json["status"],
    data: List<TaskDetailData>.from(json["data"].map((x) => TaskDetailData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class TaskDetailData {
  TaskDetailData({
    this.eventId,
    this.userId,
    this.fromContact,
    this.userName,
    this.deviceType,
    this.fromDeviceToken,
    this.toUser,
    this.toContact,
    this.fromUser,
    this.eventName,
    this.playPause,
    this.priority,
    this.date,
    this.startDate,
    this.eventFrom,
    this.eventTo,
    this.location,
    this.latitude,
    this.longitude,
    this.comingIn,
    this.radius,
    this.status,
    this.description,
    this.toDeviceToken,
    this.badge,
    this.badgeId,
    this.address,
    this.receiverProfilePic,
    this.receiverPpThumbnail,
    this.senderProfilePic,
    this.senderPpThumbnail,
    this.toUserId,
    this.eventdetail,
    this.isGroupchat,
    this.groupId,
    this.taskImg,
    this.taskThumb,
    this.audio,
    this.duration,
    this.video,
    this.vidThumb,
    this.groupName,
    this.fromUserName,
  });

  String eventId="";
  String userId;
  String fromContact;
  String userName;
  String deviceType;
  String fromDeviceToken;
  String toUser;
  String toContact;
  String fromUser;
  String eventName;
  String playPause;
  String priority;
  String date;
  String startDate;
  String eventFrom;
  String eventTo;
  String location;
  String latitude;
  String longitude;
  String comingIn;
  String radius;
  String status;
  String description;
  String toDeviceToken;
  String badge;
  String badgeId;
  String address;
  String receiverProfilePic;
  String receiverPpThumbnail;
  String senderProfilePic;
  String senderPpThumbnail;
  String toUserId;
  List<Eventdetail> eventdetail;
  String isGroupchat;
  String groupId;
  String taskImg;
  String taskThumb;
  String audio;
  String duration;
  String video;
  String vidThumb;
  String groupName;
  String fromUserName;

  factory TaskDetailData.fromJson(Map<String, dynamic> json) => TaskDetailData(
    eventId: json["event_id"],
    userId: json["user_id"],
    fromContact: json["from_contact"],
    userName: json["user_name"],
    deviceType: json["device_type"],
    fromDeviceToken: json["from_device_token"],
    toUser: json["to_user"],
    toContact: json["to_contact"],
    fromUser: json["from_user"],
    eventName: json["event_name"],
    playPause: json["play_pause"],
    priority: json["priority"],
    date: json["date"],
    startDate: json["start_date"],
    eventFrom: json["event_from"],
    eventTo: json["event_to"],
    location: json["location"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    comingIn: json["coming_in"],
    radius: json["radius"],
    status: json["status"],
    description: json["description"],
    toDeviceToken: json["to_device_token"],
    badge: json["badge"],
    badgeId: json["badge_id"],
    address: json["address"],
    receiverProfilePic: json["receiver_profile_pic"],
    receiverPpThumbnail: json["receiver_ppThumbnail"],
    senderProfilePic: json["sender_profile_pic"],
    senderPpThumbnail: json["sender_ppThumbnail"],
    toUserId: json["to_user_id"],
    eventdetail: List<Eventdetail>.from(json["Eventdetail"].map((x) => Eventdetail.fromJson(x))),
    isGroupchat: json["is_groupchat"],
    groupId: json["groupId"],
    taskImg: json["taskImg"],
    taskThumb: json["taskThumb"],
    audio: json["audio"],
    duration: json["duration"],
    video: json["video"],
    vidThumb: json["vidThumb"],
    groupName: json["groupName"],
    fromUserName: json["fromUserName"],
  );

  Map<String, dynamic> toJson() => {
    "event_id": eventId,
    "user_id": userId,
    "from_contact": fromContact,
    "user_name": userName,
    "device_type": deviceType,
    "from_device_token": fromDeviceToken,
    "to_user": toUser,
    "to_contact": toContact,
    "from_user": fromUser,
    "event_name": eventName,
    "play_pause": playPause,
    "priority": priority,
    "date": date,
    "start_date": startDate,
    "event_from": eventFrom,
    "event_to": eventTo,
    "location": location,
    "latitude": latitude,
    "longitude": longitude,
    "coming_in": comingIn,
    "radius": radius,
    "status": status,
    "description": description,
    "to_device_token": toDeviceToken,
    "badge": badge,
    "badge_id": badgeId,
    "address": address,
    "receiver_profile_pic": receiverProfilePic,
    "receiver_ppThumbnail": receiverPpThumbnail,
    "sender_profile_pic": senderProfilePic,
    "sender_ppThumbnail": senderPpThumbnail,
    "to_user_id": toUserId,
    "Eventdetail": List<dynamic>.from(eventdetail.map((x) => x.toJson())),
    "is_groupchat": isGroupchat,
    "groupId": groupId,
    "taskImg": taskImg,
    "taskThumb": taskThumb,
    "audio": audio,
    "duration": duration,
    "video": video,
    "vidThumb": vidThumb,
    "groupName": groupName,
    "fromUserName": fromUserName,
  };
}

class Eventdetail {
  Eventdetail({
    this.status,
    this.date,
  });

  String status;
  String date;

  factory Eventdetail.fromJson(Map<String, dynamic> json) => Eventdetail(
    status: json["status"],
    date: json["date"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "date": date,
  };
}
