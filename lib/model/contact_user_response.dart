// @dart=2.9
import 'dart:convert';

ContactUserResponse contactUserResponseFromJson(String str) => ContactUserResponse.fromJson(json.decode(str));

String contactUserResponseToJson(ContactUserResponse data) => json.encode(data.toJson());

class ContactUserResponse {
  ContactUserResponse({
    this.response,
  });

  ResponseData response;

  factory ContactUserResponse.fromJson(Map<String, dynamic> json) => ContactUserResponse(
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
    this.currentPage,
    this.pageSize,
    this.totalRecords,
    this.lastPage,
    this.data,
  });

  String message;
  String status;
  String currentPage;
  String pageSize;
  String totalRecords;
  String lastPage;
  List<ContactsDatum> data;

  factory ResponseData.fromJson(Map<String, dynamic> json) => ResponseData(
    message: json["message"],
    status: json["status"],
    currentPage: json["current_page"],
    pageSize: json["page_size"],
    totalRecords: json["total_records"],
    lastPage: json["last_page"],
    data: List<ContactsDatum>.from(json["data"].map((x) => ContactsDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "current_page": currentPage,
    "page_size": pageSize,
    "total_records": totalRecords,
    "last_page": lastPage,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class ContactsDatum {
  ContactsDatum({
    this.companyName,
    this.userId,
    this.fullname,
    this.contact,
    this.status,
    this.profilePic,
    this.ppThumbnail,
    this.designation,
    this.isblock,
    this.isChecked,
  });

  CompanyName companyName;
  String userId;
  String fullname;
  String contact;
  String status;
  String profilePic;
  String ppThumbnail;
  String designation;
  String isblock;
  bool isChecked= false;

  factory ContactsDatum.fromJson(Map<String, dynamic> json) => ContactsDatum(
    companyName: companyNameValues.map[json["company_name"]],
    userId: json["user_id"],
    fullname: json["fullname"],
    contact: json["contact"],
    status: json["status"],
    profilePic: json["profile_pic"],
    ppThumbnail: json["ppThumbnail"],
    designation: json["designation"],
    isblock: json["isblock"],
    isChecked: false,
  );

  Map<String, dynamic> toJson() => {
    "company_name": companyNameValues.reverse[companyName],
    "user_id": userId,
    "fullname": fullname,
    "contact": contact,
    "status": status,
    "profile_pic": profilePic,
    "ppThumbnail": ppThumbnail,
    "designation": designation,
    "isblock": isblock,
  };
}

enum CompanyName { APPZORRO }

final companyNameValues = EnumValues({
  "Appzorro": CompanyName.APPZORRO
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
