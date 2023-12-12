import 'dart:io';

import 'package:desk/api/fetch_data_exception.dart';
import 'package:desk/enum/viewstate.dart';
import 'package:desk/model/done_task_response.dart';
import 'package:desk/utils/dialog_helper.dart';
import 'package:desk/utils/string_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'base_provider.dart';

class DoneTaskProvider extends BaseProvider {
  List<Datum> doneTaskList = [];
  int lastPage=1;
  int sortBy=0;
  int currentPage = 1;

  bool showSearchBar= true;

  bool updateSeachBar(bool b){
    this.showSearchBar=b;
    notifyListeners();
  }

  Future<bool> getDoneTask(
      BuildContext context,
      String userId,
      String sortType,
      String contact,
      String pageNo,
      String companyId,
      String search) async {
    setState(ViewState.Busy);
    try {
      var data = await apiClient.doneTask(
          userId, sortType, contact, pageNo, companyId, search);
      if (data.response.status == "1") {
        lastPage = int.parse(data.response.lastPage);
        if (data.response.currentPage == '1') {
          doneTaskList=[];
        }
        doneTaskList.addAll(data.response.data);
        setState(ViewState.Idle);
      } else {
        doneTaskList=[];
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
