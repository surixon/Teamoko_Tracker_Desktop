// @dart=2.9
import 'dart:convert';

FetchTicketResponse fetchTicketResponseFromJson(String str) =>
    FetchTicketResponse.fromJson(json.decode(str));

String fetchTicketResponseToJson(FetchTicketResponse data) =>
    json.encode(data.toJson());

class FetchTicketResponse {
  FetchTicketResponse({
    this.response,
  });

  ResponseData response;

  factory FetchTicketResponse.fromJson(Map<String, dynamic> json) =>
      FetchTicketResponse(
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
  List<FetchTicketDatum> data;

  factory ResponseData.fromJson(Map<String, dynamic> json) => ResponseData(
        status: json["status"],
        message: json["message"],
        data: List<FetchTicketDatum>.from(
            json["data"].map((x) => FetchTicketDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class FetchTicketDatum {
  FetchTicketDatum({
    this.id,
    this.userId,
    this.query,
    this.status,
    this.createdDate,
    this.closeDate,
    this.userName,
    this.userEmail,
    this.isRead,
  });

  String id;
  String userId;
  String query;
  String status;
  String createdDate;
  String closeDate;
  String userName;
  String userEmail;
  String isRead;

  factory FetchTicketDatum.fromJson(Map<String, dynamic> json) =>
      FetchTicketDatum(
        id: json["id"],
        userId: json["user_id"],
        query: json["query"],
        status: json["status"],
        createdDate: json["created_date"],
        closeDate: json["close_date"],
        userName: json["user_name"],
        userEmail: json["user_email"],
        isRead: json["is_read"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "query": query,
        "status": status,
        "created_date": createdDate,
        "close_date": closeDate,
        "user_name": userName,
        "user_email": userEmail,
        "is_read": isRead,
      };
}
