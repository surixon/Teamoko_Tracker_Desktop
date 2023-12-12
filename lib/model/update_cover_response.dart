// @dart=2.9
import 'dart:convert';

UpdateCoverResponse updateCoverResponseFromJson(String str) => UpdateCoverResponse.fromJson(json.decode(str));

String updateCoverResponseToJson(UpdateCoverResponse data) => json.encode(data.toJson());

class UpdateCoverResponse {
  UpdateCoverResponse({
    this.response,
  });

  ResponseData response;

  factory UpdateCoverResponse.fromJson(Map<String, dynamic> json) => UpdateCoverResponse(
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
    this.companyId,
    this.coverPic,
  });

  String status;
  String message;
  String companyId;
  String coverPic;

  factory ResponseData.fromJson(Map<String, dynamic> json) => ResponseData(
    status: json["status"],
    message: json["message"],
    companyId: json["company_id"],
    coverPic: json["cover_pic"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "company_id": companyId,
    "cover_pic": coverPic,
  };
}
