import 'dart:io';

import 'package:desk/api/fetch_data_exception.dart';
import 'package:desk/enum/viewstate.dart';
import 'package:desk/utils/dialog_helper.dart';
import 'package:desk/utils/string_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'base_provider.dart';

class ChangePasswordProvider extends BaseProvider {


  Future<bool> changePassword(
      BuildContext context,
      String userId,
      String password) async {
    setState(ViewState.Busy);
    try {
      var data = await apiClient.changePassword(
          userId, password);
      if (data.response.status == "1") {
        DialogHelper.showMessage(context, data.response.message);
        Navigator.pop(context);
        setState(ViewState.Idle);
        return true;
      } else {
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
