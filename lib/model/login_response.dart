// @dart=2.9
import 'dart:convert';
LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    this.response,
  });

  ResponseData response;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
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
    this.companyId,
    this.userId,
    this.username,
    this.contact,
    this.type,
    this.email,
    this.noti,
  });

  String companyId;
  String userId;
  String username;
  String contact;
  String type;
  String email;
  String noti;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    companyId: json["company_id"],
    userId: json["user_id"],
    username: json["username"],
    contact: json["contact"],
    type: json["type"],
    email: json["email"],
    noti: json["noti"],
  );

  Map<String, dynamic> toJson() => {
    "company_id": companyId,
    "user_id": userId,
    "username": username,
    "contact": contact,
    "type": type,
    "email": email,
    "noti": noti,
  };
}
