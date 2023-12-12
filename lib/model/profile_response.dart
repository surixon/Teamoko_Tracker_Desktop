// @dart=2.9
import 'dart:convert';

ProfileResponse profileResponseFromJson(String str) => ProfileResponse.fromJson(json.decode(str));

String profileResponseToJson(ProfileResponse data) => json.encode(data.toJson());

class ProfileResponse {
  ProfileResponse({
    this.response,
  });

  ResponseData response;

  factory ProfileResponse.fromJson(Map<String, dynamic> json) => ProfileResponse(
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
  Data data;

  factory ResponseData.fromJson(Map<String, dynamic> json) => ResponseData(
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    this.userId,
    this.fullname,
    this.email,
    this.countryCode,
    this.contact,
    this.contactVerified,
    this.password,
    this.gender,
    this.dob,
    this.profilePic,
    this.ppThumbnail,
    this.deviceType,
    this.deviceToken,
    this.createdAt,
    this.subscribeDate,
    this.subscribeType,
    this.renewDate,
    this.companyId,
    this.type,
    this.companyName,
    this.designation,
    this.employeeId,
    this.coverPic,
    this.country,
    this.checkIn,
    this.checkinDate,
    this.totalMembers,
    this.workingHours,
    this.checkInTime,
    this.selfTask,
    this.totalTask,
    this.done,
    this.attendanceStatus,
    this.attendanceType,
    this.latitude,
    this.longitude,
    this.radius,
  });

  String userId;
  String fullname;
  String email;
  String countryCode;
  String contact;
  String contactVerified;
  String password;
  String gender;
  String dob;
  String profilePic;
  String ppThumbnail;
  String deviceType;
  String deviceToken;
  String createdAt;
  String subscribeDate;
  String subscribeType;
  String renewDate;
  String companyId;
  String type;
  String companyName;
  String designation;
  String employeeId;
  String coverPic;
  String country;
  String checkIn='';
  String checkinDate;
  String totalMembers;
  String workingHours;
  String checkInTime;
  String selfTask;
  String totalTask;
  String done;
  String attendanceStatus;
  String attendanceType;
  String latitude;
  String longitude;
  String radius;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    userId: json["user_id"],
    fullname: json["fullname"],
    email: json["email"],
    countryCode: json["country_code"],
    contact: json["contact"],
    contactVerified: json["contact_verified"],
    password: json["password"],
    gender: json["gender"],
    dob: json["dob"],
    profilePic: json["profile_pic"],
    ppThumbnail: json["ppThumbnail"],
    deviceType: json["device_type"],
    deviceToken: json["device_token"],
    createdAt: json["created_at"],
    subscribeDate:json["subscribe_date"],
    subscribeType: json["subscribe_type"],
    renewDate: json["renew_date"],
    companyId: json["company_id"],
    type: json["type"],
    companyName: json["company_name"],
    designation: json["designation"],
    employeeId: json["employee_id"],
    coverPic: json["cover_pic"],
    country: json["country"],
    checkIn: json["checkIn"],
    checkinDate: json["checkin_date"],
    totalMembers: json["total_members"],
    workingHours: json["working_hours"],
    checkInTime: json["checkInTime"],
    selfTask: json["selfTask"],
    totalTask: json["totalTask"],
    done: json["done"],
    attendanceStatus: json["attendanceStatus"],
    attendanceType: json["attendanceType"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    radius: json["radius"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "fullname": fullname,
    "email": email,
    "country_code": countryCode,
    "contact": contact,
    "contact_verified": contactVerified,
    "password": password,
    "gender": gender,
    "dob": dob,
    "profile_pic": profilePic,
    "ppThumbnail": ppThumbnail,
    "device_type": deviceType,
    "device_token": deviceToken,
    "created_at": createdAt,
    "subscribe_date": subscribeDate,
    "subscribe_type": subscribeType,
    "renew_date": renewDate,
    "company_id": companyId,
    "type": type,
    "company_name": companyName,
    "designation": designation,
    "employee_id": employeeId,
    "cover_pic": coverPic,
    "country": country,
    "checkIn": checkIn,
    "checkin_date": checkinDate,
    "total_members": totalMembers,
    "working_hours": workingHours,
    "checkInTime": checkInTime,
    "selfTask": selfTask,
    "totalTask": totalTask,
    "done": done,
    "attendanceStatus": attendanceStatus,
    "attendanceType": attendanceType,
    "latitude": latitude,
    "longitude": longitude,
    "radius": radius,
  };
}
