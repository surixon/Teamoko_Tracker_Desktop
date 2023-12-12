
// @dart=2.9
import 'dart:convert';

DeleteGroupResponse deleteGroupResponseFromJson(String str) => DeleteGroupResponse.fromJson(json.decode(str));

String deleteGroupResponseToJson(DeleteGroupResponse data) => json.encode(data.toJson());

class DeleteGroupResponse {
  DeleteGroupResponse({
    this.response,
  });

  ResponseData response;

  factory DeleteGroupResponse.fromJson(Map<String, dynamic> json) => DeleteGroupResponse(
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
  });

  String status;
  String message;

  factory ResponseData.fromJson(Map<String, dynamic> json) => ResponseData(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
