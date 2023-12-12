// @dart=2.9
import 'dart:convert';

CreateGroupResponse createGroupResponseFromJson(String str) => CreateGroupResponse.fromJson(json.decode(str));

String createGroupResponseToJson(CreateGroupResponse data) => json.encode(data.toJson());

class CreateGroupResponse {
  CreateGroupResponse({
    this.response,
  });

  ResponseData response;

  factory CreateGroupResponse.fromJson(Map<String, dynamic> json) => CreateGroupResponse(
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
    this.groupId,
  });

  String groupId;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    groupId: json["groupId"],
  );

  Map<String, dynamic> toJson() => {
    "groupId": groupId,
  };
}
