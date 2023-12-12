// @dart=2.9
import 'dart:convert';

ForgotPasswordResponse forgotPasswordResponseFromJson(String str) => ForgotPasswordResponse.fromJson(json.decode(str));

String forgotPasswordResponseToJson(ForgotPasswordResponse data) => json.encode(data.toJson());

class ForgotPasswordResponse {
  ForgotPasswordResponse({
    this.response,
  });

  ResponseData response;

  factory ForgotPasswordResponse.fromJson(Map<String, dynamic> json) => ForgotPasswordResponse(
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
