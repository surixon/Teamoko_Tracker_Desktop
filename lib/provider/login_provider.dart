import 'dart:io';

import 'package:desk/api/fetch_data_exception.dart';
import 'package:desk/enum/viewstate.dart';
import 'package:desk/utils/constants.dart';
import 'package:desk/utils/dialog_helper.dart';
import 'package:desk/utils/route_constants.dart';
import 'package:desk/utils/string_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'base_provider.dart';

class LoginProvider extends BaseProvider {

  SharedPreferences sharedPreferences = GetIt.instance.get();

  Future<bool> login(BuildContext context,String email,String password) async {
    setState(ViewState.Busy);
    try {
      var data = await apiClient.login( email,password);
      setState(ViewState.Idle);
      if (data.response.status=="1") {
        sharedPreferences.setString(userId, data.response.data.userId);
        sharedPreferences.setString(userName, data.response.data.username);
        sharedPreferences.setString(companyId, data.response.data.companyId);
        sharedPreferences.setString(phoneNumber, data.response.data.contact);
        sharedPreferences.setString(userType, data.response.data.type);
        sharedPreferences.setString(userEmail, data.response.data.email);
        Navigator.pushNamed(context, RouteConstants.main);
      } else {
        DialogHelper.showMessage(
            context, data.response.message);
        return null;
      }
    } on FetchDataException catch (c) {
      setState(ViewState.Idle);
      DialogHelper.showMessage(context, c.toString());
      return null;
    } on SocketException {
      setState(ViewState.Idle);
      DialogHelper.showMessage(context, StringConstants.no_internet);
      return null;
    }
  }


 Future<bool> forgotPassword(BuildContext context,String email) async {
    setState(ViewState.Busy);
    try {
      var data = await apiClient.forgotPassword( email);
      setState(ViewState.Idle);
      if (data.response.status=="1") {
        DialogHelper.showMessage(
            context, data.response.message);
        return true;
      } else {
        DialogHelper.showMessage(
            context, data.response.message);
        return null;
      }
    } on FetchDataException catch (c) {
      setState(ViewState.Idle);
      DialogHelper.showMessage(context, c.toString());
      return null;
    } on SocketException {
      setState(ViewState.Idle);
      DialogHelper.showMessage(context, StringConstants.no_internet);
      return null;
    }
  }

}
