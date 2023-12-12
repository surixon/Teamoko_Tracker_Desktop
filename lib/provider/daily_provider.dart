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

class DailyProvider extends BaseProvider {

  SharedPreferences _sharedPreferences = GetIt.instance.get();


  Future<bool> dailyReport(
      BuildContext context,String description) async {
    setState(ViewState.Busy);
    try {
      var data = await apiClient.dailyReport(
          _sharedPreferences.getString(userId),_sharedPreferences.getString(companyId),description);
      if (data.response.status == "1") {
        setState(ViewState.Idle);
        DialogHelper.showMessage(context, data.response.message);
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
}
