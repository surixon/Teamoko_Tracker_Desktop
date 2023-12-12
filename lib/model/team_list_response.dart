// @dart=2.9
import 'dart:convert';

TeamListResponse teamListResponseFromJson(String str) => TeamListResponse.fromJson(json.decode(str));

String teamListResponseToJson(TeamListResponse data) => json.encode(data.toJson());

class TeamListResponse {
  TeamListResponse({
    this.response,
  });

  ResponseData response;

  factory TeamListResponse.fromJson(Map<String, dynamic> json) => TeamListResponse(
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
    this.totalMembers,
    this.totalGroups,
    this.blockedMembers,
    this.data,
  });

  String message;
  String status;
  String totalMembers;
  String totalGroups;
  String blockedMembers;
  List<Datum> data;

  factory ResponseData.fromJson(Map<String, dynamic> json) => ResponseData(
    message: json["message"],
    status: json["status"],
    totalMembers: json["totalMembers"],
    totalGroups: json["totalGroups"],
    blockedMembers: json["blockedMembers"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "totalMembers": totalMembers,
    "totalGroups": totalGroups,
    "blockedMembers": blockedMembers,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.name,
    this.email,
    this.contact,
    this.profilePic,
    this.ppThumbnail,
    this.designation,
    this.isblock,
    this.userId,
    this.isOnline,
    this.employeeId,
    this.userType,
    this.workingHours,
    this.totalTask,
    this.receivedTask,
    this.msgBadge,
    this.lastMsg,
    this.isSeen,
    this.msgTime,
    this.totalTrackedTime,
    this.trackingStatus,
  });

  String name;
  String email;
  String contact;
  String profilePic;
  String ppThumbnail;
  String designation;
  String isblock;
  String userId;
  String isOnline;
  String employeeId;
  String userType;
  String workingHours;
  String totalTask;
  String receivedTask;
  String msgBadge;
  String lastMsg;
  String isSeen;
  int msgTime;
  TotalTrackedTime totalTrackedTime;
  String trackingStatus;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    name: json["name"],
    email: json["email"],
    contact: json["contact"],
    profilePic: json["profile_pic"],
    ppThumbnail: json["ppThumbnail"],
    designation: json["designation"],
    isblock: json["isblock"],
    userId: json["user_id"],
    isOnline: json["is_online"],
    employeeId: json["employee_id"],
    userType: json["user_type"],
    workingHours: json["working_hours"],
    totalTask: json["totalTask"],
    receivedTask: json["receivedTask"],
    msgBadge: json["msgBadge"],
    lastMsg: json["lastMsg"],
    isSeen: json["is_seen"],
    msgTime: json["msgTime"],
    totalTrackedTime: totalTrackedTimeValues.map[json["totalTrackedTime"]],
    trackingStatus: json["trackingStatus"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "contact": contact,
    "profile_pic": profilePic,
    "ppThumbnail": ppThumbnail,
    "designation": designation,
    "isblock": isblock,
    "user_id": userId,
    "is_online": isOnline,
    "employee_id": employeeId,
    "user_type": userType,
    "working_hours": workingHours,
    "totalTask": totalTask,
    "receivedTask": receivedTask,
    "msgBadge": msgBadge,
    "lastMsg": lastMsg,
    "is_seen": isSeen,
    "msgTime": msgTime,
    "totalTrackedTime": totalTrackedTimeValues.reverse[totalTrackedTime],
    "trackingStatus": trackingStatus,
  };
}

enum TotalTrackedTime { THE_0000 }

final totalTrackedTimeValues = EnumValues({
  "00:00": TotalTrackedTime.THE_0000
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}