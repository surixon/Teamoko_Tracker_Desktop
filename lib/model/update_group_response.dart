// @dart=2.9
import 'dart:convert';

UpdateGroupResponse updateGroupResponseFromJson(String str) => UpdateGroupResponse.fromJson(json.decode(str));

String updateGroupResponseToJson(UpdateGroupResponse data) => json.encode(data.toJson());

class UpdateGroupResponse {
  UpdateGroupResponse({
    this.response,
  });

  ResponseData response;

  factory UpdateGroupResponse.fromJson(Map<String, dynamic> json) => UpdateGroupResponse(
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
  String data;

  factory ResponseData.fromJson(Map<String, dynamic> json) => ResponseData(
    status: json["status"],
    message: json["message"],
    data: json["data"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data,
  };
}
