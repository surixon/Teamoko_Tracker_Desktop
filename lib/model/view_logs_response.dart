import 'dart:convert';

ViewLogsResponse viewLogsResponseFromJson(String str) => ViewLogsResponse.fromJson(json.decode(str));

String viewLogsResponseToJson(ViewLogsResponse data) => json.encode(data.toJson());

class ViewLogsResponse {
  ViewLogsResponse({
    this.response,
  });

  ResponseData response;

  factory ViewLogsResponse.fromJson(Map<String, dynamic> json) => ViewLogsResponse(
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
  ViewLogsData data;

  factory ResponseData.fromJson(Map<String, dynamic> json) => ResponseData(
    message: json["message"],
    status: json["status"],
    data: ViewLogsData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "data": data.toJson(),
  };
}

class ViewLogsData {
  ViewLogsData({
    this.checkIn,
    this.checkOut,
    this.interval,
    this.workingHours,
  });

  List<String> checkIn;
  List<String> checkOut;
  List<String> interval;
  String workingHours;

  factory ViewLogsData.fromJson(Map<String, dynamic> json) => ViewLogsData(
    checkIn: List<String>.from(json["check_in"].map((x) => x)),
    checkOut: List<String>.from(json["check_out"].map((x) => x)),
    interval: List<String>.from(json["interval"].map((x) => x)),
    workingHours: json["working_hours"],
  );

  Map<String, dynamic> toJson() => {
    "check_in": List<dynamic>.from(checkIn.map((x) => x)),
    "check_out": List<dynamic>.from(checkOut.map((x) => x)),
    "interval": List<dynamic>.from(interval.map((x) => x)),
    "working_hours": workingHours,
  };
}
