// @dart=2.9
import 'dart:convert';

TrackingDataResponse trackingDataResponseFromJson(String str) => TrackingDataResponse.fromJson(json.decode(str));

String trackingDataResponseToJson(TrackingDataResponse data) => json.encode(data.toJson());

class TrackingDataResponse {
  TrackingDataResponse({
    this.response,
  });

  ResponseData response;

  factory TrackingDataResponse.fromJson(Map<String, dynamic> json) => TrackingDataResponse(
    response: ResponseData.fromJson(json["response"]),
  );

  Map<String, dynamic> toJson() => {
    "response": response.toJson(),
  };
}

class ResponseData {
  ResponseData({
    this.status,
    this.message,
    this.currentPage,
    this.pageSize,
    this.totalRecords,
    this.lastPage,
    this.totalTrackedTime,
    this.data,
  });

  String status;
  String message;
  String currentPage;
  String pageSize;
  String totalRecords;
  String lastPage;
  String totalTrackedTime;
  List<TrackingDatum> data;

  factory ResponseData.fromJson(Map<String, dynamic> json) => ResponseData(
    status: json["status"],
    message: json["message"],
    currentPage: json["current_page"],
    pageSize: json["page_size"],
    totalRecords: json["total_records"],
    lastPage: json["last_page"],
    totalTrackedTime: json["totalTrackedTime"],
    data: List<TrackingDatum>.from(json["data"].map((x) => TrackingDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "current_page": currentPage,
    "page_size": pageSize,
    "total_records": totalRecords,
    "last_page": lastPage,
    "totalTrackedTime": totalTrackedTime,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class TrackingDatum {
  TrackingDatum({
    this.title,
    this.keyPressCount,
    this.mouseClickCount,
    this.screenShot,
    this.date,
    this.time,
    this.progressRank,
    this.trackedId,
  });

  String title;
  String keyPressCount;
  String mouseClickCount;
  String screenShot;
  String date;
  String time;
  String progressRank;
  String trackedId;

  factory TrackingDatum.fromJson(Map<String, dynamic> json) => TrackingDatum(
    title: json["title"],
    keyPressCount: json["keyPressCount"],
    mouseClickCount: json["mouseClickCount"],
    screenShot: json["screenShot"],
    date: json["date"],
    time: json["time"],
    progressRank: json["progressRank"],
    trackedId: json["trackedId"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "keyPressCount": keyPressCount,
    "mouseClickCount": mouseClickCount,
    "screenShot": screenShot,
    "date": date,
    "time": time,
    "progressRank": progressRank,
    "trackedId": trackedId,
  };
}
