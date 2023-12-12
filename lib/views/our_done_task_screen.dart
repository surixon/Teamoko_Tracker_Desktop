import 'package:desk/base/base_view.dart';
import 'package:desk/enum/viewstate.dart';
import 'package:desk/model/our_task_response.dart';
import 'package:desk/model/our_task_screen_arguments.dart';
import 'package:desk/provider/our_task_provider.dart';
import 'package:desk/utils/commom_colors.dart';
import 'package:desk/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OurDoneTaskScreen extends StatefulWidget {

  OurTaskScreenArguments doneTaskScreenArguments;

  OurDoneTaskScreen({this.doneTaskScreenArguments});


  @override
  _OurDoneTaskScreenState createState() => _OurDoneTaskScreenState();
}

class _OurDoneTaskScreenState extends State<OurDoneTaskScreen> {
  SharedPreferences sharedPreferences = GetIt.instance.get();
  int page = 1;
  String filterType = "1";
  String sortType = "10";
  String groupId = "";
  String search = "";

  Future _loadMore(BuildContext context, OurTaskProvider provider) async {
    provider.getOurTask(
        context,
        sharedPreferences.getString(userId),
        sortType,
        widget.doneTaskScreenArguments.groupId,
        page.toString(),
        filterType,
        widget.doneTaskScreenArguments.userId,
        search);
  }

  Text _setToUserName(Datum taskList) {
    if (taskList.isGroupchat == "1") {
      if (taskList.userId == sharedPreferences.getString(userId)) {
        return Text(sharedPreferences.getString(userName)??'',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 12.0));
      } else {
        return Text(taskList.groupName??'',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 12.0));
      }
    } else {
      if (taskList.userId == sharedPreferences.getString(userId)) {
        return Text(sharedPreferences.getString(userName)??'',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 12.0));
      } else {
        return Text(taskList.toUser??'',
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
        return Text(taskList.groupName??'',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 12.0));
      } else {
        return Text(taskList.userName??'',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 12.0));
      }
    } else {
      if (taskList.userId == sharedPreferences.getString(userId)) {
        return Text(taskList.toUser??'',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 12.0));
      } else {
        return Text(taskList.userName??'',
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
          "Done Tasks",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          SizedBox(
            width: 8.0,
          ),
          GestureDetector(
            onTap: () {

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
      body: BaseView<OurTaskProvider>(
        onModelReady: (provider) {

          provider.getOurTask(
              context,
              sharedPreferences.getString(userId),
              sortType,
              widget.doneTaskScreenArguments.groupId,
              page.toString(),
              filterType,
              widget.doneTaskScreenArguments.userId,
              search);


        },
        builder: (context, provider, _) => Container(
          child: Padding(
            padding: new EdgeInsets.only(top: statusBarHeight),
            child: Column(
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
                        _loadMore(context,provider);
                      }
                    },
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: provider.ourTaskList.length,
                        itemBuilder: (context, position) {
                          return GestureDetector(
                            onTap: () {

                            },
                            child: Column(
                              children: <Widget>[
                                Card(
                                  elevation: 4,
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  child: Container(
                                      child: Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        10.0, 8.0, 10.0, 8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Column(children: [
                                          Center(
                                            child: provider.ourTaskList[position]
                                                .isGroupchat ==
                                                "1"
                                                ? Container(
                                              height: 48,
                                              width: 48,
                                              decoration: BoxDecoration(
                                                /* borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  24)
                                                          ),*/
                                                  border: Border.all(
                                                      width: 2,
                                                      color: Colors.green,
                                                      style: BorderStyle
                                                          .solid)),
                                              child: Center(
                                                child: Text(
                                                  "AK",
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ),
                                            )
                                                : CircleAvatar(
                                              radius: 24,
                                              backgroundImage: NetworkImage(
                                                  provider
                                                      .ourTaskList[
                                                  position]
                                                      .userId ==
                                                      sharedPreferences
                                                          .getString(
                                                          userId)
                                                      ? provider
                                                      .ourTaskList[
                                                  position]
                                                      .receiverPpThumbnail
                                                      : provider
                                                      .ourTaskList[
                                                  position]
                                                      .senderPpThumbnail),
                                            ),
                                          ),
                                          SizedBox(height: 4.0,),
                                          Text(
                                            "# "+ provider.ourTaskList[position]
                                                .eventId,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                                fontSize: 13.0),
                                            maxLines: 1,
                                          ),
                                        ],),
                                        SizedBox(
                                          width: 8.0,
                                        ),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                provider.ourTaskList[position]
                                                    .eventName,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                    fontSize: 18.0),
                                                maxLines: 1,
                                              ),
                                              Row(
                                                children: [
                                                  _setToUserName(provider
                                                      .ourTaskList[position]),
                                                  SizedBox(width: 4,),

                                                  provider
                                                      .ourTaskList[
                                                  position]
                                                      .userId ==
                                                      sharedPreferences
                                                          .getString(
                                                          userId)
                                                      ? ImageIcon(
                                                    AssetImage(
                                                        "assets/images/ic_right_arrow.png"),
                                                    size: 24.0,
                                                    color: CommonColors.primaryColor,
                                                  )
                                                      : ImageIcon(
                                                    AssetImage(
                                                        "assets/images/ic_left_greenarrow.png"),
                                                    size: 24.0,
                                                    color:
                                                    CommonColors
                                                        .green,
                                                  ),

                                                  SizedBox(width: 4,),
                                                  _setFromUserName(provider
                                                      .ourTaskList[position]),
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
                                                provider.ourTaskList[position].date
                                                    .split(" ")[0],
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                    fontSize: 12.0)),
                                            _setPriority(provider
                                                .ourTaskList[position].priority),
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
                Container(
                  height: provider.state == ViewState.Busy ? 50.0 : 0,
                  color: Colors.transparent,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
