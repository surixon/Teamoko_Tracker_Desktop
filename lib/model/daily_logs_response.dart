// @dart=2.9
import 'dart:convert';

DailyLogsResponse dailyLogsResponseFromJson(String str) => DailyLogsResponse.fromJson(json.decode(str));

String dailyLogsResponseToJson(DailyLogsResponse data) => json.encode(data.toJson());

class DailyLogsResponse {
  DailyLogsResponse({
    this.response,
  });

  ResponseData response;

  factory DailyLogsResponse.fromJson(Map<String, dynamic> json) => DailyLogsResponse(
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
  List<LogsDatum> data;

  factory ResponseData.fromJson(Map<String, dynamic> json) => ResponseData(
    message: json["message"],
    status: json["status"],
    data: List<LogsDatum>.from(json["data"].map((x) => LogsDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class LogsDatum {
  LogsDatum({
    this.date,
    this.workingHours,
  });

  String date;
  String workingHours;

  factory LogsDatum.fromJson(Map<String, dynamic> json) => LogsDatum(
    date: json["date"],
    workingHours: json["working_hours"],
  );

  Map<String, dynamic> toJson() => {
    "date": date,
    "working_hours": workingHours,
  };
}
