import 'package:desk/base/base_view.dart';
import 'package:desk/enum/viewstate.dart';
import 'package:desk/model/all_task_screen_arguments.dart';
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

class AllTaskScreen extends StatefulWidget {
  AllTaskScreenArguments taskScreenArguments;

  AllTaskScreen({this.taskScreenArguments});

  @override
  _AllTaskScreenState createState() => _AllTaskScreenState();
}

class _AllTaskScreenState extends State<AllTaskScreen> {
  SharedPreferences sharedPreferences = GetIt.instance.get();
  int page = 1;
  TaskProvider _provider;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  Future _loadMore(BuildContext context, TaskProvider provider) async {
    provider.getTask(
        context,
        widget.taskScreenArguments.userId,
        provider.sortBy.toString(),
        widget.taskScreenArguments.contact,
        page.toString(),
        provider.filterBy.toString(),
        sharedPreferences.getString(companyId),
        "");
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
        return Text(taskList.groupName,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 12.0));
      }
    } else {
      if (taskList.userId == sharedPreferences.getString(userId)) {
        return Text(taskList.toUser,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 12.0));
      } else {
        return Text(taskList.userName,
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
        return Text(taskList.groupName,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 12.0));
      } else {
        return Text(taskList.fromUserName??'',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 12.0));
      }
    } else {
      if (taskList.userId == sharedPreferences.getString(userId)) {
        return Text(taskList.userName,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 12.0));
      } else {
        return Text(taskList.toUser,
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
              color: Colors.black,
              fontSize: 12.0));
    } else if (priority == "2") {
      return Text("Medium",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 12.0));
    } else if (priority == "3") {
      return Text("High",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 12.0));
    } else if (priority == "4") {
      return Text("Critical",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 12.0));
    }
  }

  void _onRefresh() async {
    _provider
        .getTask(
            context,
            widget.taskScreenArguments.userId,
            _provider.sortBy.toString(),
            widget.taskScreenArguments.contact,
            page.toString(),
            _provider.filterBy.toString(),
            sharedPreferences.getString(companyId),
            "")
        .then((value) {
      _refreshController.refreshCompleted();
    });
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.close,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "All Tasks",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: BaseView<TaskProvider>(
        onModelReady: (provider) {
          _provider = provider;
          provider.getTask(
              context,
              widget.taskScreenArguments.userId,
              provider.sortBy.toString(),
              widget.taskScreenArguments.contact,
              page.toString(),
              provider.filterBy.toString(),
              sharedPreferences.getString(companyId),
              "");
        },
        builder: (context, provider, _) => Container(
          child: Padding(
              padding: new EdgeInsets.only(top: statusBarHeight),
              child: Stack(
                children: [
                  Column(
                    children: [
                      Expanded(
                        child: NotificationListener<ScrollNotification>(
                          // ignore: missing_return
                          onNotification: (ScrollNotification scrollInfo) {
                            if (page < provider.lastPage &&
                                scrollInfo.metrics.pixels ==
                                    scrollInfo.metrics.maxScrollExtent) {
                              setState(() {
                                page = page + 1;
                              });
                              _loadMore(context, provider);
                            }
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
                                      Navigator.pushNamed(
                                          context, RouteConstants.task_details,
                                          arguments: provider
                                              .taskList[position].eventId);
                                    },
                                    child: Column(
                                      children: <Widget>[
                                        Card(
                                          elevation: 4,
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(4.0),
                                          ),
                                          child: Container(
                                              child: Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                10.0, 8.0, 10.0, 8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
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
                                                              height: 48,
                                                              width: 48,
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              24)),
                                                                  border: Border.all(
                                                                      width: 2,
                                                                      color: Colors
                                                                          .green,
                                                                      style: BorderStyle
                                                                          .solid)),
                                                              child: Center(
                                                                child: Text(
                                                                  "AK",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                              ),
                                                            )
                                                          : CircleAvatar(
                                                              radius: 24,
                                                              backgroundImage: NetworkImage(provider
                                                                          .taskList[
                                                                              position]
                                                                          .userId ==
                                                                      sharedPreferences
                                                                          .getString(
                                                                              userId)
                                                                  ? provider
                                                                      .taskList[
                                                                          position]
                                                                      .receiverPpThumbnail
                                                                  : provider
                                                                      .taskList[
                                                                          position]
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
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                          fontSize: 13.0),
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
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        provider
                                                            .taskList[position]
                                                            .eventName,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.black,
                                                            fontSize: 18.0),
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
                                                          provider
                                                                      .taskList[
                                                                          position]
                                                                      .userId ==
                                                                  sharedPreferences
                                                                      .getString(
                                                                          userId)
                                                              ? ImageIcon(
                                                                  AssetImage(
                                                                      "assets/images/ic_left_greenarrow.png"),
                                                                  size: 24.0,
                                                                  color: Colors
                                                                      .green,
                                                                )
                                                              : ImageIcon(
                                                                  AssetImage(
                                                                      "assets/images/ic_right_arrow.png"),
                                                                  size: 24.0,
                                                                  color:
                                                                      CommonColors
                                                                          .red,
                                                                ),
                                                          SizedBox(
                                                            width: 4.0,
                                                          ),
                                                          _setFromUserName(
                                                              provider.taskList[
                                                                  position]),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                        provider
                                                            .taskList[position]
                                                            .date
                                                            .split(" ")[0],
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.black,
                                                            fontSize: 12.0)),
                                                    _setPriority(provider
                                                        .taskList[position]
                                                        .priority),
                                                    Text("Pending",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.black,
                                                            fontSize: 12.0)),
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
                          ),
                        ),
                      ),
                      Container(
                        height: provider.state == ViewState.Busy ? 50.0 : 0,
                        color: Colors.transparent,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    ],
                  ),
                  Center(
                    child: provider.state == ViewState.Busy
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
