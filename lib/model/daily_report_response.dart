// @dart=2.9
import 'dart:convert';

DailyReportResponse dailyReportResponseFromJson(String str) => DailyReportResponse.fromJson(json.decode(str));

String dailyReportResponseToJson(DailyReportResponse data) => json.encode(data.toJson());

class DailyReportResponse {
  DailyReportResponse({
    this.response,
  });

  ResponseData response;

  factory DailyReportResponse.fromJson(Map<String, dynamic> json) => DailyReportResponse(
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
  });

  String message;
  String status;

  factory ResponseData.fromJson(Map<String, dynamic> json) => ResponseData(
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
  };
}