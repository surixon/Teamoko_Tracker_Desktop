import 'dart:io';

import 'package:desk/api/fetch_data_exception.dart';
import 'package:desk/enum/viewstate.dart';
import 'package:desk/model/group_list_response.dart';
import 'package:desk/utils/constants.dart';
import 'package:desk/utils/dialog_helper.dart';
import 'package:desk/utils/string_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'base_provider.dart';

class GroupProvider extends BaseProvider {
  SharedPreferences _sharedPreferences = GetIt.instance.get();
  List<GroupDatum> groupList = [];
  List<GroupDatum> groupTempList = [];

  Future<bool> getGroupList(BuildContext context, String userId, String contact,
      String companyId, String userType, String isGroup, String isBlock) async {
    setState(ViewState.Busy);
    try {
      var data = await apiClient.getGroupList(
          userId, contact, companyId, userType, isGroup, isBlock);
      if (data.response.status == "1") {
        groupTempList.addAll(data.response.data);
        groupList=groupTempList;
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

  Future<bool> createGroup(
      BuildContext context, String groupName, String toContacts) async {
    setState(ViewState.Busy);
    try {
      var data = await apiClient.createGroup(
          _sharedPreferences.getString(userId), groupName, toContacts);
      if (data.response.status == "1") {
        int count = 0;
        Navigator.popUntil(context, (route) {
          return count++ == 2;
        });
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

  Future<bool> updateGroup(
      BuildContext context, String groupId, String groupName, int index) async {
    setState(ViewState.Busy);
    try {
      var data = await apiClient.updateGroup(groupId, groupName);
      if (data.response.status == "1") {
        groupTempList[index].groupName=data.response.data;
        groupList=groupTempList;
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

  Future<bool> deleteGroup(BuildContext context, String groupId, int index) async {
    setState(ViewState.Busy);
    try {
      var data = await apiClient.deleteGroup(groupId);
      if (data.response.status == "1") {
        groupTempList.removeAt(index);
        groupList=groupTempList;
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
