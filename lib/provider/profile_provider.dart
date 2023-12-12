import 'dart:io';

import 'package:desk/api/fetch_data_exception.dart';
import 'package:desk/enum/viewstate.dart';
import 'package:desk/model/profile_response.dart';
import 'package:desk/utils/constants.dart';
import 'package:desk/utils/dialog_helper.dart';
import 'package:desk/utils/string_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'base_provider.dart';

class ProfileProvider extends BaseProvider {
  SharedPreferences _sharedPreferences = GetIt.instance.get();
  ProfileResponse profileResponse;
  File profileImageFile;
  File coverImageFile;

  Future<bool> getProfile(BuildContext context) async {
    setState(ViewState.Busy);
    try {
      var data =
          await apiClient.getProfile(_sharedPreferences.getString(userId));
      if (data.response.status == "1") {
        profileResponse = data;
        setState(ViewState.Idle);
      } else {
        DialogHelper.showMessage(context, data.response.message);
        setState(ViewState.Idle);
        return null;
      }
    } on FetchDataException catch (c) {
      DialogHelper.showMessage(context, c.toString());
      setState(ViewState.Idle);
      return null;
    } on SocketException {
      DialogHelper.showMessage(context, StringConstants.no_internet);
      setState(ViewState.Idle);
      return null;
    }
  }

  Future<bool> updateProfile(
      BuildContext context,
      String countryCode,
      String country,
      String companyId,
      String fullname,
      String designation,
      String email,
      String dob,
      String gender,
      String employeeId,
      String contact,
      File profilePic) async {
    setState(ViewState.Busy);
    try {
      var data = await apiClient.updateProfile(
          countryCode,
          country,
          companyId,
          gender,
          dob,
          employeeId,
          contact,
          fullname,
          designation,
          email,
          profilePic);
      if (data.response.status == "1") {
        profileImageFile=null;
        setState(ViewState.Idle);
        DialogHelper.showMessage(context, data.response.message);
      } else {
        DialogHelper.showMessage(context, data.response.message);
        setState(ViewState.Idle);
        return null;
      }
    } on FetchDataException catch (c) {
      DialogHelper.showMessage(context, c.toString());
      setState(ViewState.Idle);
      return null;
    } on SocketException {
      DialogHelper.showMessage(context, StringConstants.no_internet);
      setState(ViewState.Idle);
      return null;
    }
  }

  Future<bool> updateCoverPic(
    BuildContext context,
    String userId,
    File coverPic,
  ) async {
    setState(ViewState.Busy);
    try {
      var data = await apiClient.updateCoverPic(userId, coverPic);
      if (data.response.status == "1") {
        profileResponse.response.data.coverPic=data.response.coverPic;
        setState(ViewState.Idle);
        DialogHelper.showMessage(context, data.response.message);
      } else {
        DialogHelper.showMessage(context, data.response.message);
        setState(ViewState.Idle);
        return null;
      }
    } on FetchDataException catch (c) {
      DialogHelper.showMessage(context, c.toString());
      setState(ViewState.Idle);
      return null;
    } on SocketException {
      DialogHelper.showMessage(context, StringConstants.no_internet);
      setState(ViewState.Idle);
      return null;
    }
  }

  void setImage(BuildContext context, String path, String type) {
    if (type == '1') {
      coverImageFile = File('$path');
      updateCoverPic(
          context, _sharedPreferences.getString(userId), coverImageFile);
    } else {
      profileImageFile = File('$path');
    }
    notifyListeners();
  }
}
