import 'dart:convert';

UpdateProfileResponse updateProfileResponseFromJson(String str) => UpdateProfileResponse.fromJson(json.decode(str));

String updateProfileResponseToJson(UpdateProfileResponse data) => json.encode(data.toJson());

class UpdateProfileResponse {
  UpdateProfileResponse({
    this.response,
  });

  ResponseData response;

  factory UpdateProfileResponse.fromJson(Map<String, dynamic> json) => UpdateProfileResponse(
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
    this.companyName,
    this.companyEmail,
    this.country,
    this.coverPic,
    this.message,
  });

  String companyName;
  String companyEmail;
  String country;
  String coverPic;
  String message;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    companyName: json["company_name"],
    companyEmail: json["company_email"],
    country: json["country"],
    coverPic: json["cover_pic"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "company_name": companyName,
    "company_email": companyEmail,
    "country": country,
    "cover_pic": coverPic,
    "message": message,
  };
}
