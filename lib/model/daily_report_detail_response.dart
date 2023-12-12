// @dart=2.9
import 'dart:convert';

DailyReportDetailResponse dailyReportDetailResponseFromJson(String str) => DailyReportDetailResponse.fromJson(json.decode(str));

String dailyReportDetailResponseToJson(DailyReportDetailResponse data) => json.encode(data.toJson());

class DailyReportDetailResponse {
  DailyReportDetailResponse({
    this.response,
  });

  ResponseData response;

  factory DailyReportDetailResponse.fromJson(Map<String, dynamic> json) => DailyReportDetailResponse(
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
  Data data;

  factory ResponseData.fromJson(Map<String, dynamic> json) => ResponseData(
    message: json["message"],
    status: json["status"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "data": data.toJson(),
  };
}

class Data {
  Data();

  factory Data.fromJson(Map<String, dynamic> json) => Data(
  );

  Map<String, dynamic> toJson() => {
  };
}
