// @dart=2.9
import 'dart:convert';

AllTaskResponse allTaskResponseFromJson(String str) => AllTaskResponse.fromJson(json.decode(str));

String allTaskResponseToJson(AllTaskResponse data) => json.encode(data.toJson());

class AllTaskResponse {
  AllTaskResponse({
    this.response,
  });

  Response response;

  factory AllTaskResponse.fromJson(Map<String, dynamic> json) => AllTaskResponse(
    response: Response.fromJson(json["response"]),
  );

  Map<String, dynamic> toJson() => {
    "response": response.toJson(),
  };
}

class Response {
  Response({
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
  List<Map<String, String>> data;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
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
    data: List<Map<String, String>>.from(json["data"].map((x) => Map.from(x).map((k, v) => MapEntry<String, String>(k, v == null ? null : v)))),
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
    "data": List<dynamic>.from(data.map((x) => Map.from(x).map((k, v) => MapEntry<String, dynamic>(k, v == null ? null : v)))),
  };
}