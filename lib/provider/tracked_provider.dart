import 'dart:io';

import 'package:desk/api/fetch_data_exception.dart';
import 'package:desk/enum/viewstate.dart';
import 'package:desk/model/tracking_data_response.dart';
import 'package:desk/utils/dialog_helper.dart';
import 'package:desk/utils/string_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'base_provider.dart';

class TrackedProvider extends BaseProvider {

  var totalTrackedTime='';
  List<TrackingDatum> trackingDataList=[];

  Future<bool> trackedData(
      BuildContext context,
      String userId,
      String date,
      String pageNo) async {
    setState(ViewState.Busy);
    try {
      var data = await apiClient.getTrackingData(
          userId, date, pageNo);
      if (data.response.status == "1") {
        totalTrackedTime=data.response.totalTrackedTime;
        trackingDataList=data.response.data;
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
