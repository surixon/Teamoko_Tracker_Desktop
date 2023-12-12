// @dart=2.9
import 'dart:convert';

CheckInOutResponse checkInOutResponseFromJson(String str) => CheckInOutResponse.fromJson(json.decode(str));

String checkInOutResponseToJson(CheckInOutResponse data) => json.encode(data.toJson());

class CheckInOutResponse {
  CheckInOutResponse({
    this.response,
  });

  ResponseData response;

  factory CheckInOutResponse.fromJson(Map<String, dynamic> json) => CheckInOutResponse(
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
    this.checkin,
    this.messagee,
  });

  String checkin;
  String messagee;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    checkin: json["checkin"],
    messagee: json["messagee"],
  );

  Map<String, dynamic> toJson() => {
    "checkin": checkin,
    "messagee": messagee,
  };
}
