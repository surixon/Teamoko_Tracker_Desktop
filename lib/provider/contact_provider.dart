import 'dart:io';
import 'package:desk/api/fetch_data_exception.dart';
import 'package:desk/enum/viewstate.dart';
import 'package:desk/model/contact_user_response.dart';
import 'package:desk/model/group_response.dart';
import 'package:desk/utils/constants.dart';
import 'package:desk/utils/dialog_helper.dart';
import 'package:desk/utils/string_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'base_provider.dart';

class ContactProvider extends BaseProvider {
  List<ContactsDatum> contactList = [];
  List<ContactsDatum> tempContactList = [];
  List<GroupDatum> groupList = [];
  int lastPage=1;
  SharedPreferences _sharedPreferences=GetIt.instance.get();


  Future<bool> myContactList(
      BuildContext context,
      String isGroup,
      String pageNo,
      String contact,) async {
    setState(ViewState.Busy);
    try {
      var data = await apiClient.myContactList(
          _sharedPreferences.getString(userId),  _sharedPreferences.getString(companyId), isGroup, pageNo, contact);
      if (data.response.status == "1") {
        contactList=data.response.data;
        tempContactList=data.response.data;
        print("Temp Size"+"   "+tempContactList.length.toString());
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


  Future<bool> myGroupList(
      BuildContext context,
      String isGroup,
      String pageNo,
      String contact,) async {
    setState(ViewState.Busy);
    try {
      var data = await apiClient.groupList(
          _sharedPreferences.getString(userId),  _sharedPreferences.getString(companyId), isGroup, pageNo, contact);
      if (data.response.status == "1") {
        groupList=data.response.data;
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
