import 'dart:convert';

import 'package:desk/model/fetch_user_chat.dart';

UserChatResponse userChatResponseFromJson(String str) => UserChatResponse.fromJson(json.decode(str));

String userChatResponseToJson(UserChatResponse data) => json.encode(data.toJson());

class UserChatResponse {
  UserChatResponse({
    this.response,
  });

  DataResponse response;

  factory UserChatResponse.fromJson(Map<String, dynamic> json) => UserChatResponse(
    response: DataResponse.fromJson(json["response"]),
  );

  Map<String, dynamic> toJson() => {
    "response": response.toJson(),
  };
}

class DataResponse {
  DataResponse({
    this.message,
    this.status,
    this.data,
  });

  String message;
  String status;
  List<SupportChatDatum> data;

  factory DataResponse.fromJson(Map<String, dynamic> json) => DataResponse(
    message: json["message"],
    status: json["status"],
    data: List<SupportChatDatum>.from(json["data"].map((x) => SupportChatDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

