import 'dart:io';

import 'package:desk/api/fetch_data_exception.dart';
import 'package:desk/enum/viewstate.dart';
import 'package:desk/model/our_task_response.dart';
import 'package:desk/utils/dialog_helper.dart';
import 'package:desk/utils/string_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'base_provider.dart';

class OurTaskProvider extends BaseProvider {
  List<Datum> ourTaskList = [];
  int lastPage=1;
  int sortBy=1;
  int currentPage = 1;

  bool showSearchBar= true;

  bool updateSeachBar(bool b){
    this.showSearchBar=b;
    notifyListeners();
  }

  Future<bool> getOurTask(
      BuildContext context,
      String userId,
      String sortType,
      String groupId,
      String pageNo,
      String filterType,
      String toUserId,
      String search) async {
    setState(ViewState.Busy);
    try {
      var data = await apiClient.getOurTask(
          userId, sortType, groupId, pageNo, filterType, toUserId,search);
      if (data.response.status == "1") {
        lastPage=int.parse(data.response.lastPage);
        currentPage=int.parse(data.response.currentPage);
        if (data.response.currentPage == '1') {
          ourTaskList.clear();
        }
        ourTaskList.addAll(data.response.data);
        setState(ViewState.Idle);
      } else {
        ourTaskList.clear();
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
