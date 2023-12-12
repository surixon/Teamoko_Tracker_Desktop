// @dart=2.9
import 'dart:convert';

GroupListResponse groupListResponseFromJson(String str) => GroupListResponse.fromJson(json.decode(str));

String groupListResponseToJson(GroupListResponse data) => json.encode(data.toJson());

class GroupListResponse {
  GroupListResponse({
    this.response,
  });

  ResponseData response;

  factory GroupListResponse.fromJson(Map<String, dynamic> json) => GroupListResponse(
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
  int currentPage;
  int pageSize;
  String totalRecords;
  String lastPage;
  String selfTask;
  String totalTask;
  String done;
  String totalMembers;
  List<GroupDatum> data;

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
    data: List<GroupDatum>.from(json["data"].map((x) => GroupDatum.fromJson(x))),
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

class GroupDatum {
  GroupDatum({
    this.groupId,
    this.groupName,
    this.fullname,
    this.contact,
    this.totalTask,
    this.receivedTask,
    this.msgBadge,
    this.lastMsg,
    this.isSeen,
    this.msgTime,
    this.totalMembers,
    this.isAdmin,
  });

  String groupId;
  String groupName;
  String fullname;
  String contact;
  String totalTask;
  String receivedTask;
  String msgBadge;
  String lastMsg;
  String isSeen;
  int msgTime;
  String totalMembers;
  String isAdmin;

  factory GroupDatum.fromJson(Map<String, dynamic> json) => GroupDatum(
    groupId: json["groupId"],
    groupName: json["groupName"],
    fullname: json["fullname"],
    contact: json["contact"],
    totalTask: json["totalTask"],
    receivedTask: json["receivedTask"],
    msgBadge: json["msgBadge"],
    lastMsg: json["lastMsg"],
    isSeen: json["is_seen"],
    msgTime: json["msgTime"],
    totalMembers: json["totalMembers"],
    isAdmin: json["isAdmin"],
  );

  Map<String, dynamic> toJson() => {
    "groupId": groupId,
    "groupName": groupName,
    "fullname": fullname,
    "contact": contact,
    "totalTask": totalTask,
    "receivedTask": receivedTask,
    "msgBadge": msgBadge,
    "lastMsg": lastMsg,
    "is_seen": isSeen,
    "msgTime": msgTime,
    "totalMembers": totalMembers,
    "isAdmin": isAdmin,
  };
}