import 'dart:async';

import 'package:desk/base/base_view.dart';
import 'package:desk/components/tasks_filter_dialog.dart';
import 'package:desk/enum/viewstate.dart';
import 'package:desk/model/chat_screen_arguments.dart';
import 'package:desk/model/task_list_response.dart';
import 'package:desk/provider/tasks_provider.dart';
import 'package:desk/utils/commom_colors.dart';
import 'package:desk/utils/constants.dart';
import 'package:desk/utils/route_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

//wfwefwf
class TaskScreen extends StatefulWidget {
  TaskScreen({Key key}) : super(key: key);

  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  SharedPreferences sharedPreferences = GetIt.instance.get();
  TextEditingController _searchTextEditController;
  int page = 1;
  TaskProvider _provider;
  Timer searchTime;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  Future _loadMore(BuildContext context, TaskProvider provider) async {
    provider.getTask(
        context,
        sharedPreferences.getString(userId),
        provider.sortBy.toString(),
        sharedPreferences.getString(phoneNumber),
        page.toString(),
        _provider.filterBy.toString(),
        sharedPreferences.getString(companyId),
        "");
  }

  String groupShortName(String groupName) {
    String shortName = groupName;

    if (groupName.length > 2 && (!groupName.contains(" "))) {
      shortName = groupName.substring(0, 2);
    } else if (groupName.length > 2 && (groupName.contains(" "))) {
      List<String> parts = groupName.split(" ");
      shortName = parts[0].substring(0, 1) + parts[1].substring(0, 1);
    }

    return shortName;
  }

  Text _setToUserName(Datum taskList) {
    if (taskList.isGroupchat == "1") {
      if (taskList.userId == sharedPreferences.getString(userId)) {
        return Text(sharedPreferences.getString(userName),
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 12.0));
      } else {
        return Text(taskList.groupName ?? '',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 12.0));
      }
    } else {
      if (taskList.userId == sharedPreferences.getString(userId)) {
        return Text(taskList.userName ?? '',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 12.0));
      } else {
        return Text(taskList.toUser + "" ?? '',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 12.0));
      }
    }
  }

  Text _setFromUserName(Datum taskList) {
    if (taskList.isGroupchat == "1") {
      if (taskList.userId == sharedPreferences.getString(userId)) {
        return Text(taskList.groupName ?? '',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 12.0));
      } else {
        return Text(taskList.userName ?? '',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 12.0));
      }
    } else {
      if (taskList.userId == sharedPreferences.getString(userId)) {
        return Text(taskList.toUser ?? '',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 12.0));
      } else {
        return Text(taskList.userName ?? '',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 12.0));
      }
    }
  }

  Text _setPriority(String priority) {
    if (priority == "1") {
      return Text("Low",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: CommonColors.green,
              fontSize: 12.0));
    } else if (priority == "2") {
      return Text("Medium",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: CommonColors.blue,
              fontSize: 12.0));
    } else if (priority == "3") {
      return Text("High",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: CommonColors.primaryColor,
              fontSize: 12.0));
    } else if (priority == "4") {
      return Text("Critical",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: CommonColors.red,
              fontSize: 12.0));
    }
  }

  Text _setStatus(String status) {
    if (status == "0") {
      return Text("Pending",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: CommonColors.redDark,
              fontSize: 12.0));
    } else if (status == "1") {
      return Text("Accepted",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: CommonColors.green,
              fontSize: 12.0));
    } else if (status == "5") {
      return Text("Re-Opened",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: CommonColors.primaryBlue,
              fontSize: 12.0));
    } else {
      return Text(
        "",
      );
    }
  }

  void _onRefresh() async {
    _provider
        .getTask(
            context,
            sharedPreferences.getString(userId),
            _provider.sortBy.toString(),
            sharedPreferences.getString(phoneNumber),
            "1",
            _provider.filterBy.toString(),
            sharedPreferences.getString(companyId),
            '')
        .then((value) {
      _refreshController.refreshCompleted();
    });
  }

  void getTaskApiCall(String searchText) {
    _provider.getTask(
        context,
        sharedPreferences.getString(userId),
        _provider.sortBy.toString(),
        sharedPreferences.getString(phoneNumber),
        "1",
        _provider.filterBy.toString(),
        sharedPreferences.getString(companyId),
        searchText.trim());
  }

  @override
  void initState() {
    super.initState();
    _searchTextEditController = TextEditingController();
  }

  @override
  void dispose() {
    _searchTextEditController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    final searchTextField = TextField(
      style: TextStyle(color: Colors.black),
      controller: _searchTextEditController,
      onChanged: (value) {
        if (value.trim().isEmpty) return;

        const duration = Duration(microseconds: 800);
        if (searchTime != null) {
          setState(() {
            searchTime.cancel();
          });
        }
        setState(() {
          searchTime = new Timer(duration, () {
            getTaskApiCall(value);
          });
        });
      },
      cursorWidth: 1.5,
      cursorColor: Colors.black54,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hintText: "Search...",
        hintStyle: TextStyle(color: Color(0xff1B1D21)),
      ),
    );

    return BaseView<TaskProvider>(
      onModelReady: (provider) {
        _provider = provider;
        provider.getTask(
            context,
            sharedPreferences.getString(userId),
            "1",
            sharedPreferences.getString(phoneNumber),
            page.toString(),
            "1",
            sharedPreferences.getString(companyId),
            "");
      },
      builder: (context, provider, _) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          elevation: 1.0,
          backgroundColor: Colors.white,
          title: _provider.showSearchBar
              ? Text(
                  "Tasks",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black),
                )
              : searchTextField,
          actions: [
            SizedBox(
              width: 8.0,
            ),
            _provider.showSearchBar
                ? GestureDetector(
                    onTap: () {
                      _searchTextEditController.text = '';
                      _provider.updateSeachBar(false);
                    },
                    child: ImageIcon(
                      AssetImage("assets/images/ic_search.png"),
                      size: 24.0,
                      color: Colors.grey,
                    ),
                  )
                : GestureDetector(
                    onTap: () {
                      _searchTextEditController.text = '';
                      _provider.updateSeachBar(true);
                    },
                    child: ImageIcon(
                      AssetImage("assets/images/ic_cross.png"),
                      size: 20.0,
                      color: Colors.grey,
                    ),
                  ),
            SizedBox(
              width: 16.0,
            ),
            GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return TasksFilterDialog(provider: _provider);
                    });
              },
              child: ImageIcon(
                AssetImage("assets/images/ic_filter.png"),
                size: 24.0,
                color: Colors.grey,
              ),
            ),
            SizedBox(
              width: 8.0,
            ),
          ],
        ),
        body: Container(
          child: Padding(
              padding: new EdgeInsets.only(top: statusBarHeight),
              child: Stack(
                children: [
                  _provider.taskList.length == 0
                      ? Center(
                          child: Text(
                          'No tasks created yet',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ))
                      : Column(
                          children: [
                            Expanded(
                              child: NotificationListener<ScrollNotification>(
                                  onNotification:
                                      (ScrollNotification scrollInfo) {
                                    if (provider.currentPage == page &&
                                        page < provider.lastPage &&
                                        scrollInfo.metrics.pixels ==
                                            scrollInfo
                                                .metrics.maxScrollExtent) {
                                      setState(() {
                                        page = page + 1;
                                      });
                                      _loadMore(context, provider);
                                    }
                                    return null;
                                  },
                                  child: SmartRefresher(
                                    enablePullDown: true,
                                    header: WaterDropHeader(),
                                    controller: _refreshController,
                                    onRefresh: _onRefresh,
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: provider.taskList.length,
                                        itemBuilder: (context, position) {
                                          return GestureDetector(
                                            onTap: () {
                                              Navigator.pushNamed(context,
                                                  RouteConstants.task_details,
                                                  arguments: provider
                                                      .taskList[position]
                                                      .eventId);
                                            },
                                            child: Column(
                                              children: <Widget>[
                                                Card(
                                                  elevation: 4,
                                                  color: Colors.white,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4.0),
                                                  ),
                                                  child: Container(
                                                      child: Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            10.0,
                                                            8.0,
                                                            10.0,
                                                            8.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        Column(
                                                          children: [
                                                            Center(
                                                              child: provider
                                                                          .taskList[
                                                                              position]
                                                                          .isGroupchat ==
                                                                      "1"
                                                                  ? Container(
                                                                      height:
                                                                          48,
                                                                      width: 48,
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.all(Radius.circular(
                                                                              24)),
                                                                          border: Border.all(
                                                                              width: 2,
                                                                              color: Colors.green,
                                                                              style: BorderStyle.solid)),
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            Text(
                                                                          groupShortName(provider
                                                                              .taskList[position]
                                                                              .groupName),
                                                                          style:
                                                                              TextStyle(color: Colors.black),
                                                                        ),
                                                                      ),
                                                                    )
                                                                  : CircleAvatar(
                                                                      radius:
                                                                          24,
                                                                      backgroundImage: NetworkImage(provider.taskList[position].userId ==
                                                                              sharedPreferences.getString(
                                                                                  userId)
                                                                          ? provider
                                                                              .taskList[
                                                                                  position]
                                                                              .receiverPpThumbnail
                                                                          : provider
                                                                              .taskList[position]
                                                                              .senderPpThumbnail),
                                                                    ),
                                                            ),
                                                            SizedBox(
                                                              height: 4.0,
                                                            ),
                                                            Text(
                                                              "# " +
                                                                  provider
                                                                      .taskList[
                                                                          position]
                                                                      .eventId,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize:
                                                                      13.0),
                                                              maxLines: 1,
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          width: 8.0,
                                                        ),
                                                        Expanded(
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                provider
                                                                        .taskList[
                                                                            position]
                                                                        .eventName ??
                                                                    '',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        18.0),
                                                                maxLines: 1,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  _setToUserName(
                                                                      provider.taskList[
                                                                          position]),
                                                                  SizedBox(
                                                                    width: 4.0,
                                                                  ),
                                                                  provider.taskList[position].userId ==
                                                                          sharedPreferences
                                                                              .getString(userId)
                                                                      ? ImageIcon(
                                                                          AssetImage(
                                                                              "assets/images/ic_right_arrow.png"),
                                                                          size:
                                                                              24.0,
                                                                          color:
                                                                              CommonColors.primaryColor,
                                                                        )
                                                                      : ImageIcon(
                                                                          AssetImage(
                                                                              "assets/images/ic_left_greenarrow.png"),
                                                                          size:
                                                                              24.0,
                                                                          color:
                                                                              CommonColors.green,
                                                                        ),
                                                                  SizedBox(
                                                                    width: 4.0,
                                                                  ),
                                                                  _setFromUserName(
                                                                      provider.taskList[
                                                                          position]),
                                                                ],
                                                              ),
                                                              GestureDetector(
                                                                onTap: () {
                                                                  Navigator.pushNamed(
                                                                      context,
                                                                      RouteConstants
                                                                          .chat,
                                                                      arguments: ChatScreenArguments(
                                                                          '',
                                                                          '',
                                                                          '',
                                                                          '',
                                                                          provider
                                                                              .taskList[position]
                                                                              .eventId));
                                                                },
                                                                child: Row(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .chat_bubble,
                                                                      color: Colors
                                                                          .grey,
                                                                      size:
                                                                          17.0,
                                                                    ),
                                                                    SizedBox(
                                                                      width:
                                                                          2.0,
                                                                    ),
                                                                    (provider.taskList[position].isSeen ==
                                                                                null ||
                                                                            provider.taskList[position].isSeen.isEmpty)
                                                                        ? SizedBox()
                                                                        : provider.taskList[position].isSeen == '0'
                                                                            ? Icon(
                                                                                Icons.done,
                                                                                color: Colors.grey,
                                                                                size: 17.0,
                                                                              )
                                                                            : Icon(
                                                                                Icons.done_all,
                                                                                color: Colors.grey,
                                                                                size: 17.0,
                                                                              ),
                                                                    SizedBox(
                                                                      width:
                                                                          2.0,
                                                                    ),
                                                                    Expanded(
                                                                      child: provider
                                                                              .taskList[position]
                                                                              .lastMsg
                                                                              .isNotEmpty
                                                                          ? Text(
                                                                              provider.taskList[position].lastMsg,
                                                                              style: TextStyle(fontWeight: FontWeight.normal, color: Colors.grey, fontSize: 14.0),
                                                                              maxLines: 1,
                                                                            )
                                                                          : Text(
                                                                              'Chat now',
                                                                              style: TextStyle(fontWeight: FontWeight.normal, color: Colors.grey, fontSize: 14.0),
                                                                              maxLines: 1,
                                                                            ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Text(
                                                                provider
                                                                    .taskList[
                                                                        position]
                                                                    .date
                                                                    .split(
                                                                        " ")[0],
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        12.0)),
                                                            _setPriority(provider
                                                                .taskList[
                                                                    position]
                                                                .priority),
                                                            _setStatus(provider
                                                                .taskList[
                                                                    position]
                                                                .eventStatus),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  )),
                                                ),
                                                SizedBox(
                                                  height: 12.0,
                                                )
                                              ],
                                            ),
                                          );
                                        }),
                                  )),
                            ),
                            Container(
                              height:
                                  provider.state == ViewState.Busy ? 50.0 : 0,
                              color: Colors.transparent,
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            )
                          ],
                        ),
                  Center(
                    child: _provider.taskList.length == 0 &&
                            provider.state == ViewState.Busy
                        ? CircularProgressIndicator()
                        : Container(),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
