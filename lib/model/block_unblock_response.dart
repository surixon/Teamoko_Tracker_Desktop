// @dart=2.9
import 'dart:convert';

BlockUnblockResponse blockUnblockResponseFromJson(String str) => BlockUnblockResponse.fromJson(json.decode(str));

String blockUnblockResponseToJson(BlockUnblockResponse data) => json.encode(data.toJson());

class BlockUnblockResponse {
  BlockUnblockResponse({
    this.response,
  });

  ResponseData response;

  factory BlockUnblockResponse.fromJson(Map<String, dynamic> json) => BlockUnblockResponse(
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
    this.isblock,
  });

  String isblock;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    isblock: json["isblock"],
  );

  Map<String, dynamic> toJson() => {
    "isblock": isblock,
  };
}
