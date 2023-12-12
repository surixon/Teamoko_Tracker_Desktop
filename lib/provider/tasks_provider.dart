import 'dart:io';

import 'package:desk/api/fetch_data_exception.dart';
import 'package:desk/enum/viewstate.dart';
import 'package:desk/model/self_task_response.dart';
import 'package:desk/model/task_list_response.dart';
import 'package:desk/utils/constants.dart';
import 'package:desk/utils/dialog_helper.dart';
import 'package:desk/utils/string_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:desk/model/task_detail_response.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'base_provider.dart';

class TaskProvider extends BaseProvider {
  SharedPreferences sharedPreferences = GetIt.instance.get();
  List<Datum> taskList = [];
  List<SelfDatum> selfTaskList = [];
  TaskDetailData taskDetail;
  int lastPage = 1;
  int currentPage = 1;
  int sortBy = 1;
  int filterBy = 1;
  int selfSortBy = 0;

  bool showSearchBar = true;

  bool updateSeachBar(bool b) {
    this.showSearchBar = b;
    notifyListeners();
  }

  Future<bool> getTask(
      BuildContext context,
      String userId,
      String sortType,
      String contact,
      String pageNo,
      String filterType,
      String companyId,
      String search) async {
    setState(ViewState.Busy);
    try {
      var data = await apiClient.getTask(
          userId, sortType, contact, pageNo, filterType, companyId, search);
      if (data.response.status == "1") {
        lastPage = int.parse(data.response.lastPage);
        currentPage = int.parse(data.response.currentPage);
        if (data.response.currentPage == '1') {
          taskList.clear();
        }
        taskList.addAll(data.response.data);
        setState(ViewState.Idle);
      } else {
        taskList.clear();
        setState(ViewState.Idle);
        DialogHelper.showMessage(context, data.response.message);
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

  Future<bool> acceptRejectTask(BuildContext context, String uId, String status,
      String eventId, String dateStatus, String userType) async {
    setState(ViewState.Busy);
    try {
      var data = await apiClient.acceptRejectTask(
          uId, status, eventId, dateStatus, userType);
      if (data.response.status == "1") {
        setState(ViewState.Idle);
        getTaskDetail(context, eventId, sharedPreferences.getString(companyId),
            sharedPreferences.getString(userId));
      } else {
        setState(ViewState.Idle);
        DialogHelper.showMessage(context, data.response.message);
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

  Future<bool> passEvent(BuildContext context, String eventId,
      String passByContact, String toContact) async {
    setState(ViewState.Busy);
    try {
      var data = await apiClient.passEvent(eventId, passByContact, toContact);
      if (data.response.status == "1") {
        setState(ViewState.Idle);
        return true;
      } else {
        setState(ViewState.Idle);
        DialogHelper.showMessage(context, data.response.message);
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

  Future<bool> selfTask(BuildContext context, String userId, String sortType,
      String contact, String pageNo, String search) async {
    setState(ViewState.Busy);
    try {
      var data = await apiClient.getSelfTask(
          userId, sortType, contact, pageNo, search);
      if (data.response.status == "1") {
        lastPage = int.parse(data.response.lastPage);
        currentPage = int.parse(data.response.currentPage);
        if (data.response.currentPage == '1') {
          selfTaskList = [];
        }
        selfTaskList.addAll(data.response.data);
        setState(ViewState.Idle);
      } else {
        selfTaskList = [];
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

  Future<bool> getTaskDetail(BuildContext context, String eventId,
      String companyId, String userId) async {
    setState(ViewState.Busy);
    try {
      var data = await apiClient.getTaskDetail(eventId, companyId, userId);
      if (data.response.status == "1") {
        taskDetail = data.response.data[0];
        setState(ViewState.Idle);
        notifyListeners();
        return true;
      } else {
        DialogHelper.showMessage(context, data.response.message);
        setState(ViewState.Idle);
        return false;
      }
    } on FetchDataException catch (c) {
      DialogHelper.showMessage(context, c.toString());
      setState(ViewState.Idle);
      return true;
    } on SocketException {
      DialogHelper.showMessage(context, StringConstants.no_internet);
      setState(ViewState.Idle);
      return false;
    }
  }

  Future<bool> updateEvent(
      BuildContext context,
      String title,
      String priority,
      String date,
      String status,
      String description,
      String userId,
      String eventId,
      String companyId) async {
    setState(ViewState.Busy);
    try {
      var data = await apiClient.updateEvent(
          title, priority, date, status, description, eventId, companyId);
      if (data.response.status == "1") {
        setState(ViewState.Idle);
        return true;
      } else {
        DialogHelper.showMessage(context, data.response.message);
        setState(ViewState.Idle);
        return false;
      }
    } on FetchDataException catch (c) {
      DialogHelper.showMessage(context, c.toString());
      setState(ViewState.Idle);
      return true;
    } on SocketException {
      DialogHelper.showMessage(context, StringConstants.no_internet);
      setState(ViewState.Idle);
      return false;
    }
  }
}
