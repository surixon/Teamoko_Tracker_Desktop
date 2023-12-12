// @dart=2.9
import 'dart:convert';

InviteMemberResponse inviteMemberResponseFromJson(String str) => InviteMemberResponse.fromJson(json.decode(str));

String inviteMemberResponseToJson(InviteMemberResponse data) => json.encode(data.toJson());

class InviteMemberResponse {
  InviteMemberResponse({
    this.response,
  });

  ResponseData response;

  factory InviteMemberResponse.fromJson(Map<String, dynamic> json) => InviteMemberResponse(
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
  List<dynamic> data;

  factory ResponseData.fromJson(Map<String, dynamic> json) => ResponseData(
    message: json["message"],
    status: json["status"],
    data: List<dynamic>.from(json["data"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x)),
  };
}
