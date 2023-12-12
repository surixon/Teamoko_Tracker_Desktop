import 'dart:io';

import 'package:desk/api/fetch_data_exception.dart';
import 'package:desk/data/socket_io_manager.dart';
import 'package:desk/enum/viewstate.dart';
import 'package:desk/model/accept_reject_response.dart';
import 'package:desk/model/all_messages.dart';
import 'package:desk/model/task_detail_response.dart';
import 'package:desk/model/typing_data.dart';
import 'package:desk/model/upload_file_response.dart';
import 'package:desk/provider/base_provider.dart';
import 'package:desk/utils/dialog_helper.dart';
import 'package:desk/utils/string_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

class MessagesProvider extends BaseProvider {
  SocketIoManager socketIoManager = GetIt.instance.get();
  TaskDetailData taskDetail;
  final List<Output> _messages = [];
  bool _sendMessageState = false;
  bool _isTyping = false;

  bool get sendMessageState => _sendMessageState;

  bool get isTyping => _isTyping;

  List<Output> get allMessages => [..._messages];

  void addAllPreviousMessage(List<Output> messages) {
    var tempList = messages.reversed.toList();
    _messages.addAll(tempList);
    notifyListeners();
  }

  void updateSendMessageState(bool value) {
    _sendMessageState = value;
    notifyListeners();
  }

  void addMessage(Output message) {
    _messages.insert(0, message);
    notifyListeners();
  }

  void notifyIsTyping(TypingData data, String groupId) {
    if (groupId == data.groupId && data.isTyping == '1') {
      _isTyping = true;
      if (data.chatType == "1" || data.chatType == '3') {
        _isTyping = true;
      }
    } else if (groupId == data.groupId && data.isTyping == '0') {
      _isTyping = false;
    }
    notifyListeners();
  }

  Future<UploadFileResponse> uploadFile(
    BuildContext context,
    File imageFile,
  ) async {

    setState(ViewState.Busy);
    try {
      var data = await apiClient.fileUpload(imageFile);
      if (data.response.status == "1") {
        DialogHelper.showMessage(context, data.response.message);
        setState(ViewState.Idle);
        return data;
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

  Future<bool> getTaskDetail(BuildContext context, String eventId,
      String companyId, String userId) async {
    setState(ViewState.Busy);
    try {
      var data = await apiClient.getTaskDetail(eventId, companyId, userId);
      if (data.response.status == "1") {
        taskDetail = data.response.data[0];
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
      return false;
    } on SocketException {
      DialogHelper.showMessage(context, StringConstants.no_internet);
      setState(ViewState.Idle);
      return false;
    }
  }
}
