// @dart=2.9
import 'dart:convert';


FetchUserChatResponse fetchUserChatResponseFromJson(String str) => FetchUserChatResponse.fromJson(json.decode(str));

String fetchUserChatResponseToJson(FetchUserChatResponse data) => json.encode(data.toJson());

class FetchUserChatResponse {
  FetchUserChatResponse({
    this.response,
  });

  ResponseData response;

  factory FetchUserChatResponse.fromJson(Map<String, dynamic> json) => FetchUserChatResponse(
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
  List<SupportChatDatum> data;

  factory ResponseData.fromJson(Map<String, dynamic> json) => ResponseData(
    status: json["status"],
    message: json["message"],
    data: List<SupportChatDatum>.from(json["data"].map((x) => SupportChatDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class SupportChatDatum {
  SupportChatDatum({
    this.id,
    this.queryId,
    this.userId,
    this.message,
    this.created,
    this.flag,
  });

  String id;
  String queryId;
  String userId;
  String message;
  String created;
  String flag;

  factory SupportChatDatum.fromJson(Map<String, dynamic> json) => SupportChatDatum(
    id: json["id"],
    queryId: json["query_id"],
    userId: json["user_id"],
    message: json["message"],
    created: json["created"],
    flag: json["flag"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "query_id": queryId,
    "user_id": userId,
    "message": message,
    "created": created,
    "flag": flag,
  };
}
