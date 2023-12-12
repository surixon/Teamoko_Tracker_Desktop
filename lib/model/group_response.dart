// @dart=2.9
import 'dart:convert';

GroupResponse groupResponseFromJson(String str) => GroupResponse.fromJson(json.decode(str));

String groupResponseToJson(GroupResponse data) => json.encode(data.toJson());

class GroupResponse {
  GroupResponse({
    this.response,
  });

  ResponseData response;

  factory GroupResponse.fromJson(Map<String, dynamic> json) => GroupResponse(
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
    this.data,
  });

  String message;
  String status;
  String currentPage;
  String pageSize;
  String totalRecords;
  String lastPage;
  List<GroupDatum> data;

  factory ResponseData.fromJson(Map<String, dynamic> json) => ResponseData(
    message: json["message"],
    status: json["status"],
    currentPage: json["current_page"],
    pageSize: json["page_size"],
    totalRecords: json["total_records"],
    lastPage: json["last_page"],
    data: List<GroupDatum>.from(json["data"].map((x) => GroupDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "current_page": currentPage,
    "page_size": pageSize,
    "total_records": totalRecords,
    "last_page": lastPage,
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
    this.isAdmin,
  });

  String groupId;
  String groupName;
  String fullname;
  String contact;
  String totalTask;
  String isAdmin;

  factory GroupDatum.fromJson(Map<String, dynamic> json) => GroupDatum(
    groupId: json["groupId"],
    groupName: json["groupName"],
    fullname: json["fullname"],
    contact: json["contact"],
    totalTask: json["totalTask"],
    isAdmin: json["isAdmin"],
  );

  Map<String, dynamic> toJson() => {
    "groupId": groupId,
    "groupName": groupName,
    "fullname": fullname,
    "contact": contact,
    "totalTask": totalTask,
    "isAdmin": isAdmin,
  };
}