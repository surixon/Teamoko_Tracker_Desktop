import 'dart:io';

import 'package:desk/api/fetch_data_exception.dart';
import 'package:desk/enum/viewstate.dart';
import 'package:desk/utils/constants.dart';
import 'package:desk/utils/dialog_helper.dart';
import 'package:desk/utils/string_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'base_provider.dart';

class AddTaskProvider extends BaseProvider {

  var priority='4';
  SharedPreferences _sharedPreferences= GetIt.instance.get();

  Future<bool> addTask(
      BuildContext context,
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
    setState(ViewState.Busy);
    try {
      var data = await apiClient.addTask(
          _sharedPreferences.getString(userId),_sharedPreferences.getString(companyId),
          groupId, to, from, eventName, priority,date,eventFrom,eventTo,deviceToken,deviceType,dateSend,
          description,type,startDate,toContact,latitude,longitude,radius,comingIn,address,userName,groupName,imageFile,videoFile);
      if (data.response.status == "1") {
        DialogHelper.showMessage(context, data.response.message);
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



}
