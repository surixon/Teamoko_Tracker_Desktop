import 'dart:io';

import 'package:desk/api/fetch_data_exception.dart';
import 'package:desk/enum/viewstate.dart';
import 'package:desk/model/fetch_ticket_response.dart';
import 'package:desk/model/fetch_user_chat.dart';
import 'package:desk/utils/dialog_helper.dart';
import 'package:desk/utils/string_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'base_provider.dart';

class SupportProvider extends BaseProvider {
  List<FetchTicketDatum> tickets = [];
  List<SupportChatDatum> tempSupportChatList = [];
  List<SupportChatDatum> supportChat = [];

  Future<bool> genrateTicket(
      BuildContext context, String userId, String query) async {
    setState(ViewState.Busy);
    try {
      var data = await apiClient.genrateTicket(userId, query);
      if (data.response.status == "1") {
        DialogHelper.showMessage(context, data.response.message);
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

  Future<bool> fetchTicket(BuildContext context, String userId) async {
    setState(ViewState.Busy);
    try {
      var data = await apiClient.fetchTicket(userId);
      if (data.response.status == "1") {
        tickets = data.response.data;

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

  Future<bool> fetchUserChat(BuildContext context, String queryId) async {
    setState(ViewState.Busy);
    try {
      var data = await apiClient.fetchUserChat(queryId);
      if (data.response.status == "1") {
        tempSupportChatList = data.response.data;
        supportChat=tempSupportChatList;
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

  Future<bool> userChat(BuildContext context, String queryId,String userId,String query) async {
    setState(ViewState.Busy);
    try {
      var data = await apiClient.userChat(queryId,userId,query);
      if (data.response.status == "1") {
        tempSupportChatList.add(data.response.data[0]);
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
