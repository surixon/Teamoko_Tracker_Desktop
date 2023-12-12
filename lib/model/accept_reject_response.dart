// @dart=2.9
import 'dart:convert';

AcceptRejectResponse acceptRejectResponseFromJson(String str) => AcceptRejectResponse.fromJson(json.decode(str));

String acceptRejectResponseToJson(AcceptRejectResponse data) => json.encode(data.toJson());

class AcceptRejectResponse {
  AcceptRejectResponse({
    this.response,
  });

  ResponseData response;

  factory AcceptRejectResponse.fromJson(Map<String, dynamic> json) => AcceptRejectResponse(
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
    this.message,
    this.date,
    this.status,
    this.eventStatus,
    this.latitude,
    this.longitude,
    this.radius,
    this.comingIn,
    this.eventId,
    this.eventName,
  });

  String message;
  String date;
  String status;
  String eventStatus;
  String latitude;
  String longitude;
  String radius;
  String comingIn;
  String eventId;
  String eventName;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    message: json["message"],
    date: json["date"],
    status: json["status"],
    eventStatus: json["event_status"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    radius: json["radius"],
    comingIn: json["coming_in"],
    eventId: json["event_id"],
    eventName: json["event_name"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "date": date,
    "status": status,
    "event_status": eventStatus,
    "latitude": latitude,
    "longitude": longitude,
    "radius": radius,
    "coming_in": comingIn,
    "event_id": eventId,
    "event_name": eventName,
  };
}
