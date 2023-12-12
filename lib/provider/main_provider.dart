import 'dart:io';

import 'package:desk/api/fetch_data_exception.dart';
import 'package:desk/enum/viewstate.dart';
import 'package:desk/model/profile_response.dart';
import 'package:desk/utils/constants.dart';
import 'package:desk/utils/dialog_helper.dart';
import 'package:desk/utils/string_constants.dart';
import 'package:desk/views/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'base_provider.dart';

class MainProvider extends BaseProvider {

  SharedPreferences _sharedPreferences = GetIt.instance.get();
  ProfileResponse profileResponse;

  Future<bool> logout(
      BuildContext context,
      String userId,
      String deviceId) async {
    setState(ViewState.Busy);
    try {
      var data = await apiClient.logout(
          userId, deviceId);
      if (data.response.status == "1") {
        _sharedPreferences.setString(userId, null);
        _sharedPreferences.clear();
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context) {
              return LoginScreen();
            }), (Route<dynamic> route) => false);
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


  Future<bool> getProfile(
      BuildContext context) async {
    setState(ViewState.Busy);
    try {
      var data = await apiClient.getProfile(
          _sharedPreferences.getString(userId));
      if (data.response.status == "1") {
        profileResponse=data;
        setState(ViewState.Idle);
        return true;
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

  Future<bool> attendence(
      BuildContext context,String checkIn) async {
    setState(ViewState.Busy);
    try {
      var data = await apiClient.attendence(
          _sharedPreferences.getString(userId),_sharedPreferences.getString(companyId),checkIn,'0.0','0.0');
      if (data.response.status == "1") {
        DialogHelper.showMessage(context, data.response.message);
        profileResponse.response.data.checkIn=data.response.data.checkin;
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

  Future<bool> dailyReport(
      BuildContext context,String description) async {
    setState(ViewState.Busy);
    try {
      var data = await apiClient.dailyReport(
          _sharedPreferences.getString(userId),_sharedPreferences.getString(companyId),description);
      if (data.response.status == "1") {
        attendence(context, '2');
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
}
