import 'dart:io';

import 'package:desk/api/fetch_data_exception.dart';
import 'package:desk/enum/viewstate.dart';
import 'package:desk/model/group_list_response.dart';
import 'package:desk/model/team_list_response.dart';
import 'package:desk/utils/constants.dart';
import 'package:desk/utils/dialog_helper.dart';
import 'package:desk/utils/string_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'base_provider.dart';

class TeamProvider extends BaseProvider {
  List<Datum> teamList = [];
  List<GroupDatum> groupList = [];
  SharedPreferences sharedPreferences = GetIt.instance.get();

  Future<bool> getTeamList(BuildContext context, String userId, String contact,
      String companyId, String userType, String isGroup, String isBlock) async {
    setState(ViewState.Busy);
    try {
      var data = await apiClient.getTeamList(
          userId, contact, companyId, userType, isGroup, isBlock);
      if (data.response.status == "1") {
        teamList.clear();
        teamList.addAll(data.response.data);
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

  Future<bool> getGroupList(BuildContext context, String userId, String contact,
      String companyId, String userType, String isGroup, String isBlock) async {
    setState(ViewState.Busy);
    try {
      var data = await apiClient.getGroupList(
          userId, contact, companyId, userType, isGroup, isBlock);
      if (data.response.status == "1") {
        groupList.addAll(data.response.data);
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

  Future<bool> blockUnblock(
    BuildContext context,
    String uId,
    String status,
  ) async {
    setState(ViewState.Busy);
    try {
      var data = await apiClient.blockUnblockApi(uId, status);
      if (data.response.status == "1") {
        DialogHelper.showMessage(context, data.response.message);
        if (data.response.data.isblock == '0') {
          getTeamList(
              context,
              sharedPreferences.getString(userId),
              sharedPreferences.getString(phoneNumber),
              sharedPreferences.getString(companyId),
              sharedPreferences.getString(userType),
              '0',
              '1');
        } else {
          getTeamList(
              context,
              sharedPreferences.getString(userId),
              sharedPreferences.getString(phoneNumber),
              sharedPreferences.getString(companyId),
              sharedPreferences.getString(userType),
              '0',
              '1');
        }
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



  Future<bool> addRemoveAdmin(
    BuildContext context,
    String userId,
    String type,
  ) async {
    setState(ViewState.Busy);
    try {
      var data = await apiClient.addRemoveAdmin(userId, type);
      if (data.response.status == "1") {
        DialogHelper.showMessage(context, data.response.message);
        getTeamList(
            context,
            sharedPreferences.getString(userId),
            sharedPreferences.getString(phoneNumber),
            sharedPreferences.getString(companyId),
            sharedPreferences.getString(userType),
            '0',
            '');
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
