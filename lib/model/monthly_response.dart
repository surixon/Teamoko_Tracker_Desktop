
// @dart=2.9
import 'dart:convert';

MonthlyReportResponse monthlyReportResponseFromJson(String str) => MonthlyReportResponse.fromJson(json.decode(str));

String monthlyReportResponseToJson(MonthlyReportResponse data) => json.encode(data.toJson());

class MonthlyReportResponse {
  MonthlyReportResponse({
    this.response,
  });

  ResponseData response;

  factory MonthlyReportResponse.fromJson(Map<String, dynamic> json) => MonthlyReportResponse(
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
  });

  String status;
  String message;

  factory ResponseData.fromJson(Map<String, dynamic> json) => ResponseData(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}