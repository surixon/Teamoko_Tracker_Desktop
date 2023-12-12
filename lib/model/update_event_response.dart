
// @dart=2.9
import 'dart:convert';

UpdateEventResponse updateEventResponseFromJson(String str) => UpdateEventResponse.fromJson(json.decode(str));

String updateEventResponseToJson(UpdateEventResponse data) => json.encode(data.toJson());

class UpdateEventResponse {
  UpdateEventResponse({
    this.response,
  });

  ResponseData response;

  factory UpdateEventResponse.fromJson(Map<String, dynamic> json) => UpdateEventResponse(
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
    this.data,
  });

  String status;
  String message;
  Data data;

  factory ResponseData.fromJson(Map<String, dynamic> json) => ResponseData(
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    this.eventStatus,
    this.message,
    this.priority,
    this.date,
  });

  String eventStatus;
  String message;
  String priority;
  String date;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    eventStatus: json["event_status"],
    message: json["message"],
    priority: json["priority"],
    date: json["date"],
  );

  Map<String, dynamic> toJson() => {
    "event_status": eventStatus,
    "message": message,
    "priority": priority,
    "date": date,
  };
}
