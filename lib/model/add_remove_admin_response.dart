// @dart=2.9
import 'dart:convert';

AddRemoveAdminResponse addRemoveAdminResponseFromJson(String str) => AddRemoveAdminResponse.fromJson(json.decode(str));

String addRemoveAdminResponseToJson(AddRemoveAdminResponse data) => json.encode(data.toJson());

class AddRemoveAdminResponse {
  AddRemoveAdminResponse({
    this.response,
  });

  ResponseData response;

  factory AddRemoveAdminResponse.fromJson(Map<String, dynamic> json) => AddRemoveAdminResponse(
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
  });

  String message;
  String status;

  factory ResponseData.fromJson(Map<String, dynamic> json) => ResponseData(
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
  };
}
