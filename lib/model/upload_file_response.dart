import 'dart:convert';

UploadFileResponse uploadFileResponseFromJson(String str) => UploadFileResponse.fromJson(json.decode(str));

String uploadFileResponseToJson(UploadFileResponse data) => json.encode(data.toJson());

class UploadFileResponse {
  UploadFileResponse({
    this.response,
  });

  UploadResponse response;

  factory UploadFileResponse.fromJson(Map<String, dynamic> json) => UploadFileResponse(
    response: UploadResponse.fromJson(json["response"]),
  );

  Map<String, dynamic> toJson() => {
    "response": response.toJson(),
  };
}

class UploadResponse {
  UploadResponse({
    this.message,
    this.status,
    this.data,
    this.imageName,
    this.thumbnail,
  });

  String message;
  String status;
  String data;
  String imageName;
  String thumbnail;

  factory UploadResponse.fromJson(Map<String, dynamic> json) => UploadResponse(
    message: json["message"],
    status: json["status"],
    data: json["data"],
    imageName: json["imageName"],
    thumbnail: json["thumbnail"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "data": data,
    "imageName": imageName,
    "thumbnail": thumbnail,
  };
}
