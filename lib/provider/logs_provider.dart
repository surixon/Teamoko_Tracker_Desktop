import 'dart:io';

import 'package:desk/api/fetch_data_exception.dart';
import 'package:desk/enum/viewstate.dart';
import 'package:desk/model/daily_logs_response.dart';
import 'package:desk/utils/dialog_helper.dart';
import 'package:desk/utils/string_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'base_provider.dart';

class LogsProvider extends BaseProvider {
  List<LogsDatum> logsList = [];
  List<String> checkIn=[];
  List<String> checkOut=[];
  List<String> interval=[];
  String totalWorkingHours='';

  Future<bool> getLogs(
      BuildContext context,
      String userId,
      String companyId,
      String startDate,
      String endDate) async {
    setState(ViewState.Busy);
    try {
      var data = await apiClient.dailyLogs(
          userId ,companyId, startDate,endDate);
      if (data.response.status == "1") {
        logsList.addAll(data.response.data);
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



  Future<bool> viewLogsByDate(
      BuildContext context,
      String userId,
      String date,
      String companyId) async {
    setState(ViewState.Busy);
    try {
      var data = await apiClient.viewLogsByDate(
          userId ,date, companyId);
      if (data.response.status == "1") {
        totalWorkingHours=data.response.data.workingHours;
        checkIn=data.response.data.checkIn;
        checkOut=data.response.data.checkOut;
        interval=data.response.data.interval;
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



  Future<bool> dailyReportDetail(
      BuildContext context,
      String userId,
      String date,
      String companyId) async {
    setState(ViewState.Busy);
    try {
      var data = await apiClient.dailyReportDetail(
          userId ,date, companyId);
      if (data.response.status == "1") {

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
