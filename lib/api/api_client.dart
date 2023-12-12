import 'dart:async';
import 'dart:convert';
//import 'dart:core';
import 'dart:io';

import 'package:desk/model/accept_reject_response.dart';
import 'package:desk/model/add_remove_admin_response.dart';
import 'package:desk/model/add_task_response.dart';
import 'package:desk/model/block_unblock_response.dart';
import 'package:desk/model/chagne_password.dart';
import 'package:desk/model/check_in_out_response.dart';
import 'package:desk/model/contact_user_response.dart';
import 'package:desk/model/create_group_response.dart';
import 'package:desk/model/daily_logs_response.dart';
import 'package:desk/model/daily_report_detail_response.dart';
import 'package:desk/model/daily_report_response.dart';
import 'package:desk/model/delete_group_response.dart';
import 'package:desk/model/done_task_response.dart';
import 'package:desk/model/fetch_ticket_response.dart';
import 'package:desk/model/fetch_user_chat.dart';
import 'package:desk/model/forgot_password_response.dart';
import 'package:desk/model/genrate_ticket_response.dart';
import 'package:desk/model/group_list_response.dart';
import 'package:desk/model/group_response.dart';
import 'package:desk/model/invite_member_response.dart';
import 'package:desk/model/login_response.dart';
import 'package:desk/model/logout_response.dart';
import 'package:desk/model/monthly_response.dart';
import 'package:desk/model/our_task_response.dart';
import 'package:desk/model/pass_event_response.dart';
import 'package:desk/model/profile_response.dart';
import 'package:desk/model/self_task_response.dart';
import 'package:desk/model/task_detail_response.dart';
import 'package:desk/model/task_list_response.dart';
import 'package:desk/model/team_list_response.dart';
import 'package:desk/model/tracking_data_response.dart';
import 'package:desk/model/update_cover_response.dart';
import 'package:desk/model/update_event_response.dart';
import 'package:desk/model/update_group_response.dart';
import 'package:desk/model/update_profile_response.dart';
import 'package:desk/model/upload_file_response.dart';
import 'package:desk/model/user_chat.dart';
import 'package:desk/model/view_logs_response.dart';
import 'package:desk/utils/constants.dart';
import 'package:desk/utils/utils.dart';
import 'package:dio/dio.dart';

import 'fetch_data_exception.dart';

class ApiClient {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: 15000,
    receiveTimeout: 3000,
  ));

  ApiClient() {
    _dio.interceptors.add(
        LogInterceptor(responseBody: true, requestBody: true, request: true));
  }

  Future<LoginResponse> login(String email, String password) async {
    try {
      Response response = await _dio.get("api.php", queryParameters: {
        "action": "bussinessLogin",
        "email": email,
        "password": password,
        "device_type": "",
        "device_token": "",
        "fcm_token": ""
      });
      return loginResponseFromJson(response.data);
    } on DioError catch (e) {
      if (e.response != null) {
        var errorData = jsonDecode(e.response.toString());
        var errorMessage = errorData["message"];
        throw FetchDataException(errorMessage);
      } else {
        throw SocketException("");
      }
    }
  }

  Future<TasksListResponse> getTask(
      String userId,
      String sortType,
      String contact,
      String pageNo,
      String filterType,
      String companyId,
      String search) async {
    try {
      Response response = await _dio.get("api.php", queryParameters: {
        "action": "fetchUserEvents",
        "user_id": userId,
        "sort_type": sortType,
        "contact": contact,
        "pageNo": pageNo,
        "filter_type": filterType,
        "company_id": companyId,
        "search": search
      });
      return tasksResponseFromJson(response.data);
    } on DioError catch (e) {
      if (e.response != null) {
        var errorData = jsonDecode(e.response.toString());
        var errorMessage = errorData["message"];
        throw FetchDataException(errorMessage);
      } else {
        throw SocketException("");
      }
    }
  }

  Future<SelfTaskResponse> getSelfTask(String userId, String sortType,
      String contact, String pageNo, String search) async {
    try {
      Response response = await _dio.get("api.php", queryParameters: {
        "action": "selfEvents",
        "user_id": userId,
        "sort_type": sortType,
        "contact": contact,
        "pageNo": pageNo,
        "search": search
      });
      return selfTaskResponseFromJson(response.data);
    } on DioError catch (e) {
      if (e.response != null) {
        var errorData = jsonDecode(e.response.toString());
        var errorMessage = errorData["message"];
        throw FetchDataException(errorMessage);
      } else {
        throw SocketException("");
      }
    }
  }

  Future<BlockUnblockResponse> blockUnblockApi(
    String userId,
    String status,
  ) async {
    try {
      Response response = await _dio.get("api.php", queryParameters: {
        "action": "blockEmployee",
        "user_id": userId,
        "status": status
      });
      return blockUnblockResponseFromJson(response.data);
    } on DioError catch (e) {
      if (e.response != null) {
        var errorData = jsonDecode(e.response.toString());
        var errorMessage = errorData["message"];
        throw FetchDataException(errorMessage);
      } else {
        throw SocketException("");
      }
    }
  }

  Future<OurTaskResponse> getOurTask(
      String userId,
      String sortType,
      String groupId,
      String pageNo,
      String filterType,
      String toUserId,
      String search) async {
    try {
      Response response = await _dio.get("api.php", queryParameters: {
        "action": "getTaskById",
        "user_id": userId,
        "sort_type": sortType,
        "groupId": groupId,
        "pageNo": pageNo,
        "filter_type": filterType,
        "toUserId": toUserId,
        "search": search
      });
      return ourTaskResponseFromJson(response.data);
    } on DioError catch (e) {
      if (e.response != null) {
        var errorData = jsonDecode(e.response.toString());
        var errorMessage = errorData["message"];
        throw FetchDataException(errorMessage);
      } else {
        throw SocketException("");
      }
    }
  }

  Future<AddRemoveAdminResponse> addRemoveAdmin(
      String userId, String type) async {
    try {
      Response response = await _dio.get("api.php", queryParameters: {
        "action": "make_admin",
        "user_id": userId,
        "type": type,
      });
      return addRemoveAdminResponseFromJson(response.data);
    } on DioError catch (e) {
      if (e.response != null) {
        var errorData = jsonDecode(e.response.toString());
        var errorMessage = errorData["message"];
        throw FetchDataException(errorMessage);
      } else {
        throw SocketException("");
      }
    }
  }

  Future<AcceptRejectResponse> acceptRejectTask(String userId, String status,
      String eventId, String dateStatus, String userType) async {
    try {
      Response response = await _dio.get("api.php", queryParameters: {
        "action": "acceptRejectTask",
        "user_id": userId,
        "status": status,
        "event_id": eventId,
        "date_status": dateStatus,
        "usertype": userType,
      });
      return acceptRejectResponseFromJson(response.data);
    } on DioError catch (e) {
      if (e.response != null) {
        var errorData = jsonDecode(e.response.toString());
        var errorMessage = errorData["message"];
        throw FetchDataException(errorMessage);
      } else {
        throw SocketException("");
      }
    }
  }

  Future<PassEventResponse> passEvent(
      String eventId, String passByContact, String toContact) async {
    try {
      Response response = await _dio.get("api.php", queryParameters: {
        "action": "passEvent",
        "event_id": eventId,
        "passByContact": passByContact,
        "to_contact": toContact,
      });
      return passEventResponseFromJson(response.data);
    } on DioError catch (e) {
      if (e.response != null) {
        var errorData = jsonDecode(e.response.toString());
        var errorMessage = errorData["message"];
        throw FetchDataException(errorMessage);
      } else {
        throw SocketException("");
      }
    }
  }

  Future<DoneTaskResponse> doneTask(String userId, String sortType,
      String contact, String pageNo, String companyId, String search) async {
    try {
      Response response = await _dio.get("api.php", queryParameters: {
        "action": "fetchCompletedEvents",
        "user_id": userId,
        "sort_type": sortType,
        "contact": contact,
        "pageNo": pageNo,
        "company_id": companyId,
        "search": search
      });
      return doneTaskResponseFromJson(response.data);
    } on DioError catch (e) {
      if (e.response != null) {
        var errorData = jsonDecode(e.response.toString());
        var errorMessage = errorData["message"];
        throw FetchDataException(errorMessage);
      } else {
        throw SocketException("");
      }
    }
  }

  Future<UpdateEventResponse> updateEvent(
      String title,
      String priority,
      String date,
      String status,
      String description,
      String eventId,
      String companyId) async {
    try {
      Response response = await _dio.get("api.php", queryParameters: {
        "action": "updateEvent",
        "title": title,
        "priority": priority,
        "date": date,
        "status": status,
        "description": description,
        "event_id": eventId,
        "company_id": companyId
      });
      return updateEventResponseFromJson(response.data);
    } on DioError catch (e) {
      if (e.response != null) {
        var errorData = jsonDecode(e.response.toString());
        var errorMessage = errorData["message"];
        throw FetchDataException(errorMessage);
      } else {
        throw SocketException("");
      }
    }
  }

  Future<TaskDetailResponse> getTaskDetail(
      String eventId, String companyId, String userId) async {
    try {
      Response response = await _dio.get("api.php", queryParameters: {
        "action": "fetchEventDetail",
        "user_id": userId,
        "event_id": eventId,
        "company_id": companyId
      });
      return taskDetailResponseFromJson(response.data);
    } on DioError catch (e) {
      if (e.response != null) {
        var errorData = jsonDecode(e.response.toString());
        var errorMessage = errorData["message"];
        throw FetchDataException(errorMessage);
      } else {
        throw SocketException("");
      }
    }
  }

  Future<ProfileResponse> getProfile(String userId) async {
    try {
      Response response = await _dio.get("api.php", queryParameters: {
        "action": "fetchProfile",
        "user_id": userId,
      });
      return profileResponseFromJson(response.data);
    } on DioError catch (e) {
      if (e.response != null) {
        var errorData = jsonDecode(e.response.toString());
        var errorMessage = errorData["message"];
        throw FetchDataException(errorMessage);
      } else {
        throw SocketException("");
      }
    }
  }

  Future<CheckInOutResponse> attendence(String userId, String companyId,
      String checkIn, String latitude, String longitude) async {
    try {
      Response response = await _dio.get("api.php", queryParameters: {
        "action": "attendance",
        "user_id": userId,
        "company_id": companyId,
        "checkin": checkIn,
        "latitude": latitude,
        "longitude": longitude,
      });
      return checkInOutResponseFromJson(response.data);
    } on DioError catch (e) {
      if (e.response != null) {
        var errorData = jsonDecode(e.response.toString());
        var errorMessage = errorData["message"];
        throw FetchDataException(errorMessage);
      } else {
        throw SocketException("");
      }
    }
  }

  Future<TeamListResponse> getTeamList(String userId, String contact,
      String companyId, String usertype, String isGroup, String isBlock) async {
    try {
      Response response = await _dio.get("api.php", queryParameters: {
        "action": "employeeList",
        "user_id": userId,
        "contact": contact,
        "company_id": companyId,
        "usertype": usertype,
        "isGroup": isGroup,
        "isBlock": isBlock,
      });
      return teamListResponseFromJson(response.data);
    } on DioError catch (e) {
      if (e.response != null) {
        var errorData = jsonDecode(e.response.toString());
        var errorMessage = errorData["message"];
        throw FetchDataException(errorMessage);
      } else {
        throw SocketException("");
      }
    }
  }

  Future<CreateGroupResponse> createGroup(
      String userId, String groupName, String toContacts) async {
    try {
      Response response = await _dio.get("api.php", queryParameters: {
        "action": "createGroup",
        "user_id": userId,
        "groupName": groupName,
        "toContacts": toContacts,
      });
      return createGroupResponseFromJson(response.data);
    } on DioError catch (e) {
      if (e.response != null) {
        var errorData = jsonDecode(e.response.toString());
        var errorMessage = errorData["message"];
        throw FetchDataException(errorMessage);
      } else {
        throw SocketException("");
      }
    }
  }

  Future<UpdateGroupResponse> updateGroup(
      String groupId, String groupName) async {
    try {
      Response response = await _dio.get("api.php", queryParameters: {
        "action": "updateGroupName",
        "group_id": groupId,
        "groupName": groupName,
      });
      return updateGroupResponseFromJson(response.data);
    } on DioError catch (e) {
      if (e.response != null) {
        var errorData = jsonDecode(e.response.toString());
        var errorMessage = errorData["message"];
        throw FetchDataException(errorMessage);
      } else {
        throw SocketException("");
      }
    }
  }

  Future<InviteMemberResponse> inviteMember(
      String email, String emails, String companyId) async {
    try {
      Response response = await _dio.get("api.php", queryParameters: {
        "action": "inviteUser1",
        "email": email,
        "emails": emails,
        "company_id": companyId,
      });
      return inviteMemberResponseFromJson(response.data);
    } on DioError catch (e) {
      if (e.response != null) {
        var errorData = jsonDecode(e.response.toString());
        var errorMessage = errorData["message"];
        throw FetchDataException(errorMessage);
      } else {
        throw SocketException("");
      }
    }
  }

  Future<DeleteGroupResponse> deleteGroup(String groupId) async {
    try {
      Response response = await _dio.get("api.php", queryParameters: {
        "action": "deleteGroup",
        "group_id": groupId,
      });
      return deleteGroupResponseFromJson(response.data);
    } on DioError catch (e) {
      if (e.response != null) {
        var errorData = jsonDecode(e.response.toString());
        var errorMessage = errorData["message"];
        throw FetchDataException(errorMessage);
      } else {
        throw SocketException("");
      }
    }
  }

  Future<GroupListResponse> getGroupList(String userId, String contact,
      String companyId, String usertype, String isGroup, String isBlock) async {
    try {
      Response response = await _dio.get("api.php", queryParameters: {
        "action": "employeeList",
        "user_id": userId,
        "contact": contact,
        "company_id": companyId,
        "usertype": usertype,
        "isGroup": isGroup,
        "isBlock": isBlock,
      });
      return groupListResponseFromJson(response.data);
    } on DioError catch (e) {
      if (e.response != null) {
        var errorData = jsonDecode(e.response.toString());
        var errorMessage = errorData["message"];
        throw FetchDataException(errorMessage);
      } else {
        throw SocketException("");
      }
    }
  }

  Future<DailyReportResponse> dailyReport(
      String userId, String companyId, String description) async {
    try {
      Response response = await _dio.get("api.php", queryParameters: {
        "action": "daily_report",
        "user_id": userId,
        "company_id": companyId,
        "description": description,
      });
      return dailyReportResponseFromJson(response.data);
    } on DioError catch (e) {
      if (e.response != null) {
        var errorData = jsonDecode(e.response.toString());
        var errorMessage = errorData["message"];
        throw FetchDataException(errorMessage);
      } else {
        throw SocketException("");
      }
    }
  }

  Future<TrackingDataResponse> getTrackingData(
      String userId, String date, String pageNo) async {
    try {
      Response response = await _dio.get("api.php", queryParameters: {
        "action": "getTrackedData",
        "user_id": userId,
        "date": date,
        "pageNo": pageNo,
      });
      return trackingDataResponseFromJson(response.data);
    } on DioError catch (e) {
      if (e.response != null) {
        var errorData = jsonDecode(e.response.toString());
        var errorMessage = errorData["message"];
        throw FetchDataException(errorMessage);
      } else {
        throw SocketException("");
      }
    }
  }

  Future<ChangePasswordResponse> changePassword(
      String userId, String newPassword) async {
    try {
      Response response = await _dio.get("api.php", queryParameters: {
        "action": "changePass",
        "user_id": userId,
        "oldpassword": '',
        "newpassword": newPassword,
      });
      return changePasswordResponseFromJson(response.data);
    } on DioError catch (e) {
      if (e.response != null) {
        var errorData = jsonDecode(e.response.toString());
        var errorMessage = errorData["message"];
        throw FetchDataException(errorMessage);
      } else {
        throw SocketException("");
      }
    }
  }

  Future<GenrateTicketResponse> genrateTicket(
      String userId, String query) async {
    try {
      Response response = await _dio.get("api.php", queryParameters: {
        "action": "genrateTicket",
        "user_id": userId,
        "query": query,
      });
      return genrateTicketResponseFromJson(response.data);
    } on DioError catch (e) {
      if (e.response != null) {
        var errorData = jsonDecode(e.response.toString());
        var errorMessage = errorData["message"];
        throw FetchDataException(errorMessage);
      } else {
        throw SocketException("");
      }
    }
  }

  Future<FetchTicketResponse> fetchTicket(String userId) async {
    try {
      Response response = await _dio.get("api.php", queryParameters: {
        "action": "fetchTicket",
        "user_id": userId,
      });
      return fetchTicketResponseFromJson(response.data);
    } on DioError catch (e) {
      if (e.response != null) {
        var errorData = jsonDecode(e.response.toString());
        var errorMessage = errorData["message"];
        throw FetchDataException(errorMessage);
      } else {
        throw SocketException("");
      }
    }
  }

  Future<FetchUserChatResponse> fetchUserChat(String queryId) async {
    try {
      Response response = await _dio.get("api.php", queryParameters: {
        "action": "fetchUserChat",
        "query_id": queryId,
      });
      return fetchUserChatResponseFromJson(response.data);
    } on DioError catch (e) {
      if (e.response != null) {
        var errorData = jsonDecode(e.response.toString());
        var errorMessage = errorData["message"];
        throw FetchDataException(errorMessage);
      } else {
        throw SocketException("");
      }
    }
  }

  Future<UpdateCoverResponse> updateCoverPic(
      String userId, File coverPic) async {
    try {
      FormData formData = FormData.fromMap({
        "action": "edit_coverPic",
        "user_id": userId,
        "cover_pic": coverPic == null
            ? ''
            : await MultipartFile.fromFile(coverPic.path,
                filename: "image.png"),
      });
      var response = await _dio.post("api.php", data: formData);
      return updateCoverResponseFromJson(response.data);
    } on DioError catch (e) {
      if (e.response != null) {
        var errorData = jsonDecode(e.response.toString());
        var errorMessage = errorData["message"];
        throw FetchDataException(errorMessage);
      } else {
        throw SocketException("");
      }
    }
  }

  Future<UserChatResponse> userChat(
      String queryId, String userId, String query) async {
    try {
      Response response = await _dio.get("api.php", queryParameters: {
        "action": "UserChat",
        "query_id": queryId,
        "user_id": userId,
        "query": query,
      });
      return userChatResponseFromJson(response.data);
    } on DioError catch (e) {
      if (e.response != null) {
        var errorData = jsonDecode(e.response.toString());
        var errorMessage = errorData["message"];
        throw FetchDataException(errorMessage);
      } else {
        throw SocketException("");
      }
    }
  }

  Future<MonthlyReportResponse> sendReport(String userId, String companyId,
      String firstDate, String lastDate) async {
    try {
      Response response = await _dio.get("api.php", queryParameters: {
        "action": "sendMonthlyReport",
        "user_id": userId,
        "company_id": companyId,
        "first_date": firstDate,
        "last_date": lastDate,
      });
      return monthlyReportResponseFromJson(response.data);
    } on DioError catch (e) {
      if (e.response != null) {
        var errorData = jsonDecode(e.response.toString());
        var errorMessage = errorData["message"];
        throw FetchDataException(errorMessage);
      } else {
        throw SocketException("");
      }
    }
  }

  Future<DailyLogsResponse> dailyLogs(
      String userId, String companyId, String startDate, String endDate) async {
    try {
      Response response = await _dio.get("api.php", queryParameters: {
        "action": "attendance_logs",
        "user_id": userId,
        "company_id": companyId,
        "start_date": startDate,
        "end_date": endDate,
      });
      return dailyLogsResponseFromJson(response.data);
    } on DioError catch (e) {
      if (e.response != null) {
        var errorData = jsonDecode(e.response.toString());
        var errorMessage = errorData["message"];
        throw FetchDataException(errorMessage);
      } else {
        throw SocketException("");
      }
    }
  }

  Future<AddTaskResponse> addTask(
      String userId,
      String companyId,
      String groupId,
      String to,
      String from,
      String eventName,
      String priority,
      String date,
      String eventFrom,
      String eventTo,
      String deviceToken,
      String deviceType,
      String dateSend,
      String description,
      String type,
      String startDate,
      String toContact,
      String latitude,
      String longitude,
      String radius,
      String comingIn,
      String address,
      String userName,
      String groupName,
      File imageFile,
      File videoFile) async {
    try {
      FormData formData = FormData.fromMap({
        "action": "addTaskCopy",
        "user_id": userId,
        "company_id": companyId,
        "image": imageFile == null
            ? ''
            : await MultipartFile.fromFile(imageFile.path,
                filename: "image.png"),
        "audio": '',
        "duration": '',
        "video": videoFile == null
            ? ''
            : await MultipartFile.fromFile(videoFile.path,
                filename: "video.mp4"),
        "vidThumb": '',
        "group_id": '',
        "to": to,
        "from": from,
        "event_name": eventName,
        "priority": priority,
        "date": date,
        "sort_date": date,
        "event_from": eventFrom,
        "event_to": eventTo,
        "device_token": deviceToken,
        "device_type": deviceType,
        "date_send": dateSend,
        "description": description,
        "type": type,
        "start_date": startDate,
        "to_contact": toContact,
        "latitude": latitude,
        "longitude": longitude,
        "radius": radius,
        "coming_in": comingIn,
        "address": address,
        "user_name": userName,
        "group_name": groupName,
      });
      var response = await _dio.post("api.php", data: formData);
      return addTaskResponseFromJson(response.data);
    } on DioError catch (e) {
      if (e.response != null) {
        var errorData = jsonDecode(e.response.toString());
        var errorMessage = errorData["message"];
        throw FetchDataException(errorMessage);
      } else {
        throw SocketException("");
      }
    }
  }

  Future<UpdateProfileResponse> updateProfile(
      String countryCode,
      String country,
      String companyId,
      String gender,
      String dob,
      String employeeId,
      String contact,
      String fullname,
      String designation,
      String email,
      File profilePic) async {
    try {
      FormData formData = FormData.fromMap({
        "action": "userprofile",
        "country_code": countryCode,
        "country": country,
        "company_id": companyId,
        "gender": gender,
        "dob": dob,
        "employee_id": employeeId,
        "contact": contact,
        "fullname": fullname,
        "designation": designation,
        "email": email,
        "profile_pic": profilePic == null
            ? ''
            : await MultipartFile.fromFile(profilePic.path,
                filename: "image.png"),
      });
      var response = await _dio.post("api.php", data: formData);
      return updateProfileResponseFromJson(response.data);
    } on DioError catch (e) {
      if (e.response != null) {
        var errorData = jsonDecode(e.response.toString());
        var errorMessage = errorData["message"];
        throw FetchDataException(errorMessage);
      } else {
        throw SocketException("");
      }
    }
  }

  Future<UploadFileResponse> fileUpload(
    File imageFile,
  ) async {
    try {
      FormData formData = FormData.fromMap({
        "action": "fileUpload",
        "fileType": 'I',
        "file": imageFile == null
            ? ''
            : await MultipartFile.fromFile(imageFile.path,
                filename: Utils.getCurrentFormattedDateTime()),
      });
      var response = await _dio.post("api.php", data: formData);
      return uploadFileResponseFromJson(response.data);
    } on DioError catch (e) {
      if (e.response != null) {
        var errorData = jsonDecode(e.response.toString());
        var errorMessage = errorData["message"];
        throw FetchDataException(errorMessage);
      } else {
        throw SocketException("");
      }
    }
  }

  Future<ContactUserResponse> myContactList(String userId, String companyId,
      String isGroup, String pageNo, String contacts) async {
    try {
      Response response = await _dio.get("api.php", queryParameters: {
        "action": "myContactUser",
        "user_id": userId,
        "company_id": companyId,
        "isGroup": isGroup,
        "pageNo": pageNo,
        "contacts": contacts,
      });
      return contactUserResponseFromJson(response.data);
    } on DioError catch (e) {
      if (e.response != null) {
        var errorData = jsonDecode(e.response.toString());
        var errorMessage = errorData["message"];
        throw FetchDataException(errorMessage);
      } else {
        throw SocketException("");
      }
    }
  }

  Future<GroupResponse> groupList(String userId, String companyId,
      String isGroup, String pageNo, String contacts) async {
    try {
      Response response = await _dio.get("api.php", queryParameters: {
        "action": "myContactUser",
        "user_id": userId,
        "company_id": companyId,
        "isGroup": isGroup,
        "pageNo": pageNo,
        "contacts": contacts,
      });
      return groupResponseFromJson(response.data);
    } on DioError catch (e) {
      if (e.response != null) {
        var errorData = jsonDecode(e.response.toString());
        var errorMessage = errorData["message"];
        throw FetchDataException(errorMessage);
      } else {
        throw SocketException("");
      }
    }
  }

  Future<ForgotPasswordResponse> forgotPassword(String email) async {
    try {
      Response response = await _dio.get("api.php", queryParameters: {
        "action": "forgot_password",
        "email": email,
      });
      return forgotPasswordResponseFromJson(response.data);
    } on DioError catch (e) {
      if (e.response != null) {
        var errorData = jsonDecode(e.response.toString());
        var errorMessage = errorData["message"];
        throw FetchDataException(errorMessage);
      } else {
        throw SocketException("");
      }
    }
  }

  Future<ViewLogsResponse> viewLogsByDate(
      String userId, String date, String companyId) async {
    try {
      Response response = await _dio.get("api.php", queryParameters: {
        "action": "view_logs",
        "user_id": userId,
        "date": date,
        "company_id": companyId,
      });
      return viewLogsResponseFromJson(response.data);
    } on DioError catch (e) {
      if (e.response != null) {
        var errorData = jsonDecode(e.response.toString());
        var errorMessage = errorData["message"];
        throw FetchDataException(errorMessage);
      } else {
        throw SocketException("");
      }
    }
  }

  Future<DailyReportDetailResponse> dailyReportDetail(
      String userId, String date, String companyId) async {
    try {
      Response response = await _dio.get("api.php", queryParameters: {
        "action": "fetch_report",
        "user_id": userId,
        "date": date,
        "company_id": companyId,
      });
      return dailyReportDetailResponseFromJson(response.data);
    } on DioError catch (e) {
      if (e.response != null) {
        var errorData = jsonDecode(e.response.toString());
        var errorMessage = errorData["message"];
        throw FetchDataException(errorMessage);
      } else {
        throw SocketException("");
      }
    }
  }

  Future<LogoutResponse> logout(String userId, String deviceId) async {
    try {
      Response response = await _dio.get("api.php", queryParameters: {
        "action": "logout",
        "user_id": userId,
        "device_id": deviceId
      });
      return logoutResponseFromJson(response.data);
    } on DioError catch (e) {
      if (e.response != null) {
        var errorData = jsonDecode(e.response.toString());
        var errorMessage = errorData["message"];
        throw FetchDataException(errorMessage);
      } else {
        throw SocketException("");
      }
    }
  }
}
