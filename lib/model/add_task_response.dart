// @dart=2.9
import 'dart:convert';

AddTaskResponse addTaskResponseFromJson(String str) => AddTaskResponse.fromJson(json.decode(str));

String addTaskResponseToJson(AddTaskResponse data) => json.encode(data.toJson());

class AddTaskResponse {
  AddTaskResponse({
    this.response,
  });

  ResponseData response;

  factory AddTaskResponse.fromJson(Map<String, dynamic> json) => AddTaskResponse(
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
  Data({
    this.alarmStatus,
    this.eventId,
    this.message,
  });

  String alarmStatus;
  String eventId;
  String message;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    alarmStatus: json["alarm_status"],
    eventId: json["event_id"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "alarm_status": alarmStatus,
    "event_id": eventId,
    "message": message,
  };
}
