// @dart=2.9
import 'dart:convert';

PassEventResponse passEventResponseFromJson(String str) => PassEventResponse.fromJson(json.decode(str));

String passEventResponseToJson(PassEventResponse data) => json.encode(data.toJson());

class PassEventResponse {
  PassEventResponse({
    this.response,
  });

  ResponseData response;

  factory PassEventResponse.fromJson(Map<String, dynamic> json) => PassEventResponse(
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
  String data;

  factory ResponseData.fromJson(Map<String, dynamic> json) => ResponseData(
    message: json["message"],
    status: json["status"],
    data: json["data"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "data": data,
  };
}
