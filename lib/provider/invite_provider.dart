import 'dart:io';

import 'package:desk/api/fetch_data_exception.dart';
import 'package:desk/enum/viewstate.dart';
import 'package:desk/utils/dialog_helper.dart';
import 'package:desk/utils/string_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'base_provider.dart';

class InviteProvider extends BaseProvider {

  List<String> emailList = [];
  String totalEmail = "";

  Future<bool> inviteMember(
      BuildContext context,
      String email,
      String emails,
      String companyId) async {
    setState(ViewState.Busy);
    try {
      var data = await apiClient.inviteMember(
          email, emails, companyId);
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

  void removeItem(int position) {
    emailList.removeAt(position);
    totalEmail=(int.parse(totalEmail)-1).toString();
     notifyListeners();
  }

  void updateTotalEmailCount() {
    totalEmail = emailList.length.toString();
      notifyListeners();
  }

}
