// @dart=2.9
import 'dart:convert';

GenrateTicketResponse genrateTicketResponseFromJson(String str) => GenrateTicketResponse.fromJson(json.decode(str));

String genrateTicketResponseToJson(GenrateTicketResponse data) => json.encode(data.toJson());

class GenrateTicketResponse {
  GenrateTicketResponse({
    this.response,
  });

  ResponseData response;

  factory GenrateTicketResponse.fromJson(Map<String, dynamic> json) => GenrateTicketResponse(
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
    this.queryId,
  });

  String message;
  String status;
  String queryId;

  factory ResponseData.fromJson(Map<String, dynamic> json) => ResponseData(
    message: json["message"],
    status: json["status"],
    queryId: json["query_id"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "query_id": queryId,
  };
}
